#!/usr/bin/python

import os
import cgi
import json

# DEFINE VARS
arguments = cgi.FieldStorage()

# GET DATA
for key in arguments.keys():
  if 'dir' in key:
    directory = arguments[key].value

if '/var/rundeck/projects/Print_Ops/gcodes/' in directory:
  output_data = os.listdir(directory)
else:
  exit(2)

# OUTPUT DATA
print "Content-Type: application/json"
print ""
print json.dumps(sorted(output_data))
