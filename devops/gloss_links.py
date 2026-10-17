#!/usr/bin/env python3
"""
Build the glossary's "found in" include files, with links to the pages.

For each term in the glossary source file (one "term<TAB>definition"
per line), this finds the site pages whose text mentions the term and
writes devops/templates/<Term_Name>.txt, which gloss.html includes,
containing links to those pages.

Only templates that are served as pages are searched: the chapter
pages (found from the get_pg_w_quiz() calls in devops/views.py) plus
the few extra pages in EXTRA_PAGES.

Usage (normally run by `make gloss`):
    python3 devops/gloss_links.py templates/gloss_terms.txt devops/templates
"""
import html
import os
import re
import sys

DEVOPS_DIR = os.path.dirname(os.path.abspath(__file__))
VIEWS = os.path.join(DEVOPS_DIR, 'views.py')

# template name -> (URL, link text or None to use the page's <h1>)
EXTRA_PAGES = {
    'about': ('/devops/about', None),
    'teams': ('/devops/teams', None),
}

# pages that exist but shouldn't be listed (no_quiz is a test page)
SKIP_PAGES = {'no_quiz'}


def filenm_from_key(key):
    return key.replace(" ", "_")


def chapter_modules(templ_dir):
    """
    Modules rendered as chapter pages (found from views.py), in the
    order the home page lists them; any it doesn't list come last.
    """
    with open(VIEWS, encoding='utf-8') as f:
        modules = re.findall(r"get_pg_w_quiz\(request,\s*'(\w+)'\)",
                             f.read())
    with open(os.path.join(templ_dir, 'index.html'), encoding='utf-8') as f:
        course_order = re.findall(r'href="/devops/(\w+)"', f.read())
    return sorted(modules, key=lambda m: (m not in course_order,
                                          course_order.index(m)
                                          if m in course_order else 0))


def visible_text(source):
    """Template source minus tags, template tags and comments."""
    source = re.sub(r'{%.*?%}|{#.*?#}|{{.*?}}', ' ', source, flags=re.S)
    source = re.sub(r'<!--.*?-->|<script.*?</script>', ' ', source,
                    flags=re.S | re.I)
    return html.unescape(re.sub(r'<[^>]+>', ' ', source))


def page_title(source, default):
    match = re.search(r'<h1[^>]*>(.*?)</h1>', source, flags=re.S | re.I)
    if not match:
        return default
    title = ' '.join(visible_text(match.group(1)).split())
    return title or default


def site_pages(templ_dir):
    """List of (url, title, text) for each page we link to."""
    pages = {name: ('/devops/' + name, None)
             for name in chapter_modules(templ_dir)}
    pages.update(EXTRA_PAGES)
    result = []
    for name, (url, title) in pages.items():
        path = os.path.join(templ_dir, name + '.html')
        if name in SKIP_PAGES or not os.path.exists(path):
            continue
        with open(path, encoding='utf-8') as f:
            source = f.read()
        result.append((url, title or page_title(source, name),
                       visible_text(source)))
    return result


def found_in_html(term, pages):
    # treat hyphens and spaces alike: "Infrastructure-as-Code" should
    # match "infrastructure as code"
    words = [re.escape(w) for w in re.split(r'[-\s]+', term)]
    pattern = re.compile(r'\b' + r'[-\s]+'.join(words) + r'\b', re.I)
    links = [f'<a href="{url}">{html.escape(title)}</a>'
             for url, title, text in pages if pattern.search(text)]
    if not links:
        return ''
    return ('<span class="found-in">Found in: ' + ', '.join(links)
            + '</span>\n')


def main(gloss_src, templ_dir):
    with open(gloss_src, encoding='utf-8') as f:
        terms = [line.split('\t')[0].strip() for line in f if line.strip()]
    pages = site_pages(templ_dir)
    for term in terms:
        out = os.path.join(templ_dir, filenm_from_key(term) + '.txt')
        with open(out, 'w', encoding='utf-8') as f:
            f.write(found_in_html(term, pages))


if __name__ == '__main__':
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
