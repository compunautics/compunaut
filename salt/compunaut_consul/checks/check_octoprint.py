#!/usr/bin/python

# import modules
import requests
import json

# define request
headers={"X-Api-Key":"{{ pillar.compunaut_consul.secrets.octoprint_api_key }}","Content-Type":"application/json"}
url="http://127.0.0.1:5000/api/printer?exclude=temperature,sd"

# make request and receive response
r = requests.get(url, headers=headers)
if r.status_code is not 200:
  print "Invalid response code: maybe printer is not connected"
  exit(2)

response = r.json()

# parse response
operational = response['state']['flags']['operational']
error = response['state']['flags']['error']
paused = response['state']['flags']['paused']
printing = response['state']['flags']['printing']

if operational is False:
  print "Printer is not operational"
  exit(2)

if error is True:
  print "Printer is in error state"
  exit(2)

if paused is True:
  print "Printer is in paused state"
  exit(2)

if printing is True:
  print "Printer is printing"
  exit(2)

print "Printer is ready to accept jobs"
exit(0)
