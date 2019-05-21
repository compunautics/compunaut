#!/usr/bin/python

# import modules
import requests
import json
import socket

# define vars
hostname = socket.gethostname()
headers = {"X-Api-Key":"{{ pillar.telegraf.secrets.octoprint_api_key }}","Content-Type":"application/json"}
printer_url = "http://localhost:5000/api/printer"
printer_data = {}
consul_url = "http://localhost:8500/v1/agent/services"
consul_data = {}

# make requests and receive responses
try:
  # octoprint 
  r = requests.get(printer_url, headers=headers)
  if r.status_code is not 200:
    print "Invalid response code from Octoprint."
    exit(2)

  printer_response = r.json()

  # consul
  r = requests.get(consul_url)
  if r.status_code is not 200:
    print "Invalid response code from Consul."
    exit(2)

  consul_response = r.json()

except Exception as e:
  print e

# parse responses
try:
  # octoprint
  if printer_response['state']['flags']['printing'] == True:
    printer_data['printing'] = 1
  else:
    printer_data['printing'] = 0

  if printer_response['state']['flags']['operational'] == True:
    printer_data['operational'] = 1
  else:
    printer_data['operational'] = 0

  printer_data['bed_actual'] = printer_response['temperature']['bed']['actual']
  printer_data['bed_target'] = printer_response['temperature']['bed']['target']
  printer_data['tool_actual'] = printer_response['temperature']['tool0']['actual']
  printer_data['tool_target'] = printer_response['temperature']['tool0']['target']

  # consul
  for service, data in consul_response.iteritems():
    if 'filament' in service:
      consul_data['filament_name'] = service
      break
    else:
      consul_data['filament_name'] = "none_registered"

except Exception as e:
  print e

# print data to influxdb
print "octoprint,name=printing state="+str(printer_data['printing'])
print "octoprint,name=operational state="+str(printer_data['operational'])
print "octoprint,name=bed_actual temp="+str(printer_data['bed_actual'])
print "octoprint,name=bed_target temp="+str(printer_data['bed_target'])
print "octoprint,name=tool_actual temp="+str(printer_data['tool_actual'])
print "octoprint,name=tool_target temp="+str(printer_data['tool_target'])
print "octoprint,name=registered_filament,filament_name="+str(consul_data['filament_name'])+" filament=\""+str(consul_data['filament_name'])+"\",node=\""+hostname+"\""
