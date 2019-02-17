#!/bin/bash

# Log into vms and configure salt
  echo "Log into vms and configure hostname and salt..."
  for ip in $(virsh net-dumpxml br1 | grep -oP "(?<=ip\=\').+?(?=\'\/>)"); do
    while [[ ! $(nc -vz ${ip} 22 2>&1 | grep -io "succeeded") ]]; do
      echo "Not all minions are ready. Waiting 5 seconds..."
      sleep 5
    done
    vm=$(virsh net-dumpxml br1 | grep ${ip} | grep -oP "(?<=name\=\').+?(?=\')")
    sshpass -p 'C0mpun4ut1cs!' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l compunaut ${ip} \
      "sudo growpart /dev/vda 2; \
      sudo growpart /dev/vda 5; \
      sudo pvresize /dev/vda5; \
      if [[ ${vm} == *'netboot'* ]]; then sudo lvcreate -l 100%FREE -n piserver compunaut-minion-vg; sudo mkfs -t ext4 /dev/compunaut-minion-vg/piserver; else sudo lvextend -l +100%FREE /dev/mapper/compunaut--minion--vg-root; sudo resize2fs /dev/mapper/compunaut--minion--vg-root; fi; \
      sudo hostnamectl set-hostname ${vm} && \
      sudo sed -ri 's/compunaut-minion/${vm}\n{{ master_ip }}\tsalt/g' /etc/hosts && \
      sudo sed -ri 's/#master_finger:.+$/master_finger: {{ master_key }}/g' /etc/salt/minion && \
      sudo systemctl start salt-minion && \
      sudo systemctl enable salt-minion"
  done
