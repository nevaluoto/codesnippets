#Simple script to help find interesting domains when hunting for malicious/fraudulent entries
#in a list of newly registered domains

#Usage: domainparse.py input_file.txt

import os
import sys
from os.path import basename
from re import sub

terms = [] #List of terms which exist as part of the domain name
pre_terms = [] #These will be searched for at the beginning of the domain, e.g. "bank-" or "customer-"

f_in = open(sys.argv[1], 'r')
fileContents = f_in.readlines()
f_out = open('suspicious_domains.txt', 'a')

for term in terms:  
    for line in fileContents:
        if term in line:
           print('found: ' + line)
           f_out.write(line)

for term in pre_terms:
    for line in fileContents:
        if line.startswith(term):
            print('found: ' + line)
            f_out.write(line)
