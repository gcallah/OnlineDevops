"""
Load quiz questions for one module from a text file in quizzes/.

The file format is the one used in quizzes/*.txt:

    1. (1 point)
    The question text...?

    *a. the correct answer (marked with *)
    b. another answer
    c. ...

Questions whose text is already in the database for that module are
skipped, so the command is safe to re-run after adding questions to the
file.

Usage:
    python manage.py import_questions cicd quizzes/cicd.txt --dry-run
    python manage.py import_questions cicd quizzes/cicd.txt
"""
import re

from django.core.management.base import BaseCommand, CommandError
from django.db import transaction

from devops.models import Question, Quiz, QUEST_LEN, ANS_LEN, MODNM_LEN

HEADER_RE = re.compile(r'^\d+\.\s*\(.*\)\s*$')
ANSWER_RE = re.compile(r'^(\*?)([a-e])\.\s+(.*)$')


def normalize(text):
    return ' '.join(text.split()).casefold()


def parse_questions(path):
    """Return a list of dicts: text, correct, answers {letter: text}."""
    questions = []
    current = None
    with open(path, encoding='utf-8') as f:
        for lineno, raw in enumerate(f, 1):
            line = raw.strip()
            if not line:
                continue
            if HEADER_RE.match(line):
                current = {'text': '', 'correct': [], 'answers': {},
                           'line': lineno}
                questions.append(current)
                continue
            if current is None:
                raise CommandError(f"{path}:{lineno}: text before the first "
                                   "numbered question")
            answer = ANSWER_RE.match(line)
            if answer:
                star, letter, text = answer.groups()
                current['answers'][letter] = text.strip()
                if star:
                    current['correct'].append(letter)
            elif current['answers']:
                raise CommandError(f"{path}:{lineno}: unexpected line after "
                                   f"the answers: {line!r}")
            else:
                current['text'] = (current['text'] + ' ' + line).strip()
    return questions


def check(q, path):
    where = f"{path}:{q['line']}"
    problems = []
    if not q['text']:
        problems.append("no question text")
    elif len(q['text']) > QUEST_LEN:
        problems.append(f"question longer than {QUEST_LEN} characters")
    if len(q['answers']) < 2:
        problems.append("fewer than two answers")
    if len(q['correct']) != 1:
        problems.append("needs exactly one answer marked with *")
    for letter, text in q['answers'].items():
        if len(text) > ANS_LEN:
            problems.append(f"answer {letter} longer than {ANS_LEN} "
                            "characters")
    if problems:
        raise CommandError(f"{where}: {'; '.join(problems)}")


class Command(BaseCommand):
    help = "Import quiz questions for a module from a quizzes/*.txt file."

    def add_arguments(self, parser):
        parser.add_argument('module', help="Module name, e.g. cicd")
        parser.add_argument('path',
                            help="Question file, e.g. quizzes/cicd.txt")
        parser.add_argument('--dry-run', action='store_true',
                            help="Report what would be added; save nothing.")

    def handle(self, *args, **opts):
        module, path = opts['module'], opts['path']
        if len(module) > MODNM_LEN:
            raise CommandError(f"module name longer than {MODNM_LEN} "
                               "characters")
        questions = parse_questions(path)
        for q in questions:
            check(q, path)

        existing = {normalize(t) for t in Question.objects
                    .filter(module=module).values_list('text', flat=True)}
        new = [q for q in questions if normalize(q['text']) not in existing]

        for q in new:
            self.stdout.write(f"  + {q['text']}")
        verb = "Would add" if opts['dry_run'] else "Added"
        self.stdout.write(f"{verb} {len(new)} of {len(questions)} questions "
                          f"for '{module}' ({len(questions) - len(new)} "
                          "already present).")
        if opts['dry_run'] or not new:
            return

        with transaction.atomic():
            Question.objects.bulk_create([
                Question(module=module, text=q['text'],
                         correct=q['correct'][0], qtype='MCHOICE',
                         difficulty=1,
                         **{f'answer{letter.upper()}': text
                            for letter, text in q['answers'].items()})
                for q in new])
        if not Quiz.objects.filter(module=module).exists():
            self.stdout.write(self.style.WARNING(
                f"Note: there is no Quiz row for '{module}', so its page "
                "will draw the default number of questions."))
