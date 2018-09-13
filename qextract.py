#!/usr/bin/env python3

"""
This file contains code to extract quiz question from Django controlled db.

Functions:
    read_records()
    write_records()
    main()
"""

import os
import sys
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
django.setup()
from devops.models import *

desired_flds = ['text', 'correct', 'answerA', 'answerB', 'answerC',
                'answerD', 'answerE']

def read_records(mod_nm):
    recs = None
    if mod_nm is None:
        recs = Question.objects.values()
    else:
        recs = Question.objects.filter(module=mod_nm).values()
    return recs

def write_records(recs):
    """
        Args:
            filenm: where to output the CSV
            recs: the data to output
        Returns:
            None (for now: we probably want success or error codes)
    """
    i = 1
    # 'j' will be used for writing answer options that aren't blank
    j = ["c.", "d.", "e."]
    for question in recs:
        print(str(i) + ". (1 point)")
        print(question["text"])
        print()
        # the answers get printed here: * the correct one
        print("a. " + question["answerA"])
        print("b. " + question["answerB"])
        # making sure the rest aren't blank!
        k = [question["answerC"], question["answerD"], question["answerE"]]
        for option in k:
            if option:
                # matching the index for 'j' & 'k' to get correct alphabet
                print(j[k.index(option)] + " " + option)
            else:
                break
        i += 1
        print()

def main():
    mod_nm = None
    if len(sys.argv) > 1:
        mod_nm = sys.argv[1]

    recs = read_records(mod_nm)
    write_records(recs)

if __name__ == '__main__':
    main()
