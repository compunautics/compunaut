#!/usr/bin/python

import json

# DEFINE VARIABLES
bool_path = "/etc/consul.d/filament_bool"

# PERFORM CHECK
with open(bool_path, 'r') as infile:
  status = json.load(infile)

if status['is_available'] == 'True':
  print "Filament available"
  exit(0)
else:
  print "Filament unavailable"
  exit(2)
