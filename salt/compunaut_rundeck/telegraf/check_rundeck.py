#!/usr/bin/python

# import modules
import urllib3
import requests
import json

# disable ssl warning
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# define variables
username = '{{ pillar.telegraf.secrets.rundeck_admin_user }}'
password = '{{ pillar.telegraf.secrets.rundeck_admin_unencrypted_password }}'
data = {
  'j_username':username,
  'j_password':password
}

project = 'Print_Ops'
url = 'http://localhost:4440'
auth_endpoint = '/j_security_check'
api_endpoint = '/api/14/project/'+project+'/executions/running'

rundeck_data = []

# make requests and receive responses
try:
  session = requests.Session()
  session.verify = False
  r = session.post(url+auth_endpoint, data=data)

  if r.status_code is not 200:
    print "Invalid response code from Rundeck when authenticating."
    exit(2)

  session.params.update({'format':'json'})

  r = session.post(url+api_endpoint)

  if r.status_code is not 200:
    print "Invalid response code from Rundeck when getting running executions."
    exit(2)

  jobs = json.loads(r.content)

except Exception as e:
  print e

# parse responses
try:
  if jobs['executions']:
    for job in jobs['executions']:
      rundeck_data.append({
        'job_name': job['job']['name'].replace(" ", "_"),
        'date_started': job['date-started']['date'],
        'user': job['user']
      })

except Exception as e:
  print e

# print data to influxdb
for job in rundeck_data:
  print "rundeck,name=running_job job_name=\""+job['job_name']+"\",date_started=\""+job['date_started']+"\",user=\""+job['user']+"\""
