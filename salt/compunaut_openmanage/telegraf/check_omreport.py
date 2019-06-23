#!/usr/bin/python
### FROM https://github.com/asciiphil/perc-status/blob/master/perc-status
#State = EnumClass({
#        1:                'Ready',
#        2:                'Failed',
#        4:                'Online',
#        8:                'Offline',
#        32:               'Degraded',
#        4096:             'Non-RAID',
#        2097152:          'Replacing',
#        8388608:          'Rebuilding',
#        34359738368:      'Background Initialization',
#        274877906944:     'Foreign',
#        549755813888:     'Clear',
#        9007199254740992: 'Degraded Redundancy',
#    })
#Status = EnumClass({
#        2: 'Ok',
#        3: 'Non-Critical',
#        4: 'Critical',
#    })
### HELP ALSO RECEIVED FROM
# https://github.com/bobmshannon/gomreport/blob/master/structs.go 

import subprocess
import xmltodict

#######
### GET OMREPORT STORAGE OUTPUT
omreport = "/opt/dell/srvadmin/bin/omreport storage pdisk controller=0 -fmt xml"
process = subprocess.Popen(omreport.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Parse omreport output to dictionary
omreport_output = xmltodict.parse(output)

# Print results of disk query
for disk_device in omreport_output['OMA']['ArrayDisks']['DCStorageObject']:
  disk_id = disk_device['DeviceID']['#text']
  disk_state = disk_device['ObjState']['#text']
  print "omreport,disk_id="+disk_id+" state="+disk_state

#######
### GET OMREPORT MEMORY OUTPUT
omreport = "/opt/dell/srvadmin/bin/omreport chassis memory -fmt xml"
process = subprocess.Popen(omreport.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Parse omreport output to dictionary
omreport_output = xmltodict.parse(output)

# Print results of memory query
for memory_slot in omreport_output['OMA']['MemDevObj']:
  memory_id = memory_slot['DeviceLocator']
  error_count = memory_slot['errCount']
  print "omreport,memory_id="+memory_id+" error_count="+error_count

#######
### GET OMREPORT POWERSUPPLY OUTPUT
omreport = "/opt/dell/srvadmin/bin/omreport chassis pwrsupplies -fmt xml"
process = subprocess.Popen(omreport.split(), stdout=subprocess.PIPE)
output, error = process.communicate()

# Parse omreport output to dictionary
omreport_output = xmltodict.parse(output)

for power_supply in omreport_output['OMA']['Chassis']['PowerSupplyList']['PowerSupply']:
  ps_id = power_supply['@index']
  ps_state = power_supply['@status']
  print "omreport,ps_id="+ps_id+" ps_state="+ps_state
