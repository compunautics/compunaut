#!/usr/bin/python

# import modules
import requests
import json
import socket

# define vars
hostname = socket.gethostname()
headers = {"X-Api-Key":"{{ pillar.telegraf.secrets.octoprint_api_key }}","Content-Type":"application/json"}
printer_url = "http://localhost:5000/api/printer"
printer_job_url = "http://localhost:5000/api/job"
printer_data = {}
consul_agent_url = "http://localhost:8500/v1/agent/services"
consul_health_url = "http://localhost:8500/v1/agent/health/service/name/"
consul_data = {}

# make requests and receive responses
try:
  # octoprint 
  r = requests.get(printer_url, headers=headers)
  if r.status_code is not 200:
    print "Invalid response code from Octoprint when getting printer info."
    exit(2)

  printer_response = r.json()

  r = requests.get(printer_job_url, headers=headers)
  if r.status_code is not 200:
    print "Invalid response code from Octoprint when getting job info."
    exit(2)

  printer_job_response = r.json()

  # consul
  r = requests.get(consul_agent_url)
  if r.status_code is not 200:
    print "Invalid response code from Consul."
    exit(2)

  consul_response = r.json()

except Exception as e:
  print e

# parse responses
try:
  # octoprint printer status
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

  # octoprint job status
  if type(printer_job_response['progress']['completion']) in (float, int) :
    printer_data['progress'] = round(printer_job_response['progress']['completion'], 2)
  else:
    printer_data['progress'] = 'N/A'

  # consul
  for service, data in consul_response.iteritems():
    if 'filament' in service:
      consul_data['filament_name'] = service

      # get the service health
      consul_service_url = consul_health_url + consul_data['filament_name']
      r = requests.get(consul_service_url)

      service_health = r.json()
      if service_health[0]['AggregatedStatus'] == 'passing':
        consul_data['filament_status'] = 'available'
      elif service_health[0]['AggregatedStatus'] == 'critical':
        consul_data['filament_status'] = 'unavailable'

      break
    else:
      consul_data['filament_name'] = "none_registered"
      consul_data['filament_status'] = "none_registered"

except Exception as e:
  print e

# print data to influxdb
print "octoprint,name=printing state="+str(printer_data['printing'])
print "octoprint,name=operational state="+str(printer_data['operational'])
print "octoprint,name=bed_actual temp="+str(printer_data['bed_actual'])
print "octoprint,name=bed_target temp="+str(printer_data['bed_target'])
print "octoprint,name=tool_actual temp="+str(printer_data['tool_actual'])
print "octoprint,name=tool_target temp="+str(printer_data['tool_target'])
print "octoprint,name=job_progress progress="+str(printer_data['progress'])
print "octoprint,name=registered_filament,filament_name="+str(consul_data['filament_name'])+" filament=\""+str(consul_data['filament_name'])+"\",node=\""+hostname+"\""
print "octoprint,name=filament_status,filament_name="+str(consul_data['filament_name'])+" status=\""+str(consul_data['filament_status'])+"\",node=\""+hostname+"\""
