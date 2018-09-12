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
import csv
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
    # next two lines are just for debugging:
    for rec in recs:
            print(rec)
    return recs

def write_records(filenm, recs):
    """
        Args:
            filenm: where to output the CSV
            recs: the data to output 
        Returns:
            None (for now: we probably want success or error codes)
    """
    with open(filenm, "w") as f_out:
        fwriter = csv.writer(f_out)
        for record in recs:
            output = []
            for (key, val) in record.items():
                # next line just for debugging:
                print("Key = " + str(key) + "; Val = " + str(val))
                if key in desired_flds:
                    output.append(val)
            fwriter.writerow(output)

def main():
    mod_nm = None
    outf = None
    if len(sys.argv) < 2:
        print("You must supply an output file name.")
        exit(1)
    else:
        outf = sys.argv[1]
    if len(sys.argv) > 2:
        mod_nm = sys.argv[2]

    recs = read_records(mod_nm)
    write_records(outf, recs)

if __name__ == '__main__':
    main()
