"""
Rewrite Wikimedia Commons thumbnail URLs to widths Wikimedia still serves.

Wikimedia now only renders thumbnails at a fixed set of widths
(see https://w.wiki/GHai) and returns HTTP 400 for any other width,
which shows up on our pages as a broken image.

Usage:
    python manage.py fix_wiki_thumbs --dry-run   # show what would change
    python manage.py fix_wiki_thumbs             # update the database
    python manage.py fix_wiki_thumbs --files devops/templates/*.html
"""
import re
import time
import urllib.error
import urllib.request

from django.core.management.base import BaseCommand

from devops.models import CourseModule, ModuleSection, Extras

ALLOWED_WIDTHS = [20, 40, 60, 120, 250, 330, 500, 960, 1280]

THUMB_RE = re.compile(
    r'(https?://upload\.wikimedia\.org/wikipedia/commons)/thumb/'
    r'([0-9a-f]/[0-9a-f]{2}/[^/"\'\s]+)/(\d+)px-([^"\'\s<>]+)')

USER_AGENT = 'OnlineDevops fix_wiki_thumbs (https://www.thedevopscourse.com)'

# (model, text fields) that may hold HTML with image links:
DB_FIELDS = [
    (CourseModule, ['content']),
    (ModuleSection, ['content']),
    (Extras, ['content']),
]


def url_works(url, tries=6):
    req = urllib.request.Request(url, headers={'User-Agent': USER_AGENT})
    works = False
    for attempt in range(tries):
        time.sleep(1)  # be polite: Wikimedia rate-limits bursts
        try:
            with urllib.request.urlopen(req, timeout=20) as resp:
                works = (resp.status == 200 and
                         resp.headers.get_content_type().startswith('image/'))
            break
        except urllib.error.HTTPError as err:
            if err.code != 429:
                break
            # rate-limited: wait and try again rather than give up
            retry_after = err.headers.get('Retry-After', '')
            delay = int(retry_after) if retry_after.isdigit() else 0
            time.sleep(max(delay, 2 ** (attempt + 1)))
        except Exception:
            break
    return works


def candidates(width):
    """Allowed widths, nearest to the requested one first."""
    return sorted(ALLOWED_WIDTHS, key=lambda w: (abs(w - width), -w))


class Command(BaseCommand):
    help = "Fix Wikimedia thumbnail URLs that use no-longer-allowed widths."

    def add_arguments(self, parser):
        parser.add_argument('--dry-run', action='store_true',
                            help="Report changes without saving them.")
        parser.add_argument('--files', nargs='+', metavar='FILE',
                            help="Fix these files instead of the database.")
        parser.add_argument('--no-check', action='store_true',
                            help="Don't fetch URLs to confirm they load.")

    def handle(self, *args, **opts):
        self.dry_run = opts['dry_run']
        self.check = not opts['no_check']
        self.cache = {}
        self.changed = 0
        if opts['files']:
            for path in opts['files']:
                self.fix_file(path)
        else:
            self.fix_db()
        verb = "Would change" if self.dry_run else "Changed"
        self.stdout.write(f"{verb} {self.changed} URL(s).")

    def new_url(self, match):
        base, path, width, name = match.groups()
        width = int(width)
        if width in ALLOWED_WIDTHS:
            return match.group(0)
        old = match.group(0)
        if old in self.cache:
            return self.cache[old]
        new = None
        for w in candidates(width):
            # Wikimedia won't upscale rasters, so only trust a larger
            # width if we can confirm it loads.
            if w > width and not self.check:
                continue
            url = f'{base}/thumb/{path}/{w}px-{name}'
            if not self.check or url_works(url):
                new = url
                break
        if new is None:
            new = f'{base}/{path}'  # the full-size original
        self.stdout.write(f"  {old}\n    -> {new}")
        self.cache[old] = new
        self.changed += 1
        return new

    def fix_text(self, text):
        return THUMB_RE.sub(self.new_url, text) if text else text

    def fix_file(self, path):
        with open(path, encoding='utf-8') as f:
            text = f.read()
        fixed = self.fix_text(text)
        if fixed != text:
            self.stdout.write(f"{path}")
            if not self.dry_run:
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(fixed)

    def fix_db(self):
        for model, fields in DB_FIELDS:
            for obj in model.objects.all():
                dirty = []
                for field in fields:
                    text = getattr(obj, field)
                    fixed = self.fix_text(text)
                    if fixed != text:
                        setattr(obj, field, fixed)
                        dirty.append(field)
                if dirty:
                    self.stdout.write(f"{model.__name__} {obj.pk}: "
                                      f"{', '.join(dirty)}")
                    if not self.dry_run:
                        obj.save(update_fields=dirty)
