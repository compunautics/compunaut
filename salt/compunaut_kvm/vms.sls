include:
  - compunaut_kvm.images

{%- set local_minion = grains['id'] %}
{%- for node, attrs in salt['pillar.get']('compunaut_kvm').items() %}
  {%- if local_minion in node %}
    {%- for attr, vals in attrs.items() %}
      {%- if 'vms' in attr %}
        {%- for vm, args in vals.items()|sort %}
          {%- set vm_name = vm + "." + pillar.compunaut.vars.domain %}
# SET UP COMPUNAUT VMS
# copy base image
copy_{{ vm_name }}_image:
  cmd.run:
    - name: cp /srv/salt-images/compunaut-minion.qcow2 /srv/salt-images/{{ vm_name }}.qcow2
    - runas: root
    - unless: ls /srv/salt-images/{{ vm_name }}.qcow2
    - require:
      - file: /srv/salt-images/compunaut-minion.qcow2

          {%- if args.disk is defined %}
            {%- if salt['file.file_exists']('/srv/salt-images/'+vm_name+'.qcow2') %}
              {%- set image = '/srv/salt-images/'+vm_name+'.qcow2' %}
            {%- else %}
              {%- set image = '/srv/salt-images/compunaut-minion.qcow2' %}
            {%- endif %}
# resize disk image if pillar is defined
            {%- set prior_size = salt['cmd.shell']("qemu-img info "+image+" | awk '/virtual/{print $3}' | cut -dG -f1") %}
'qemu-img resize /srv/salt-images/{{ vm_name }}.qcow2 +{{ args.disk|int - prior_size|int }}G':
  cmd.run:
    - runas: root
    - require:
      - cmd: copy_{{ vm_name }}_image
          {%- endif %}

          {%- if args.public_mac is defined %}
# if public mac exists in pillar, attach to br0 (public network)
'virt-install -n {{ vm_name }} --memory {{ args.memory }} --vcpus {{ args.vcpu }} --os-type=linux --os-variant=ubuntu16.04 --virt-type kvm --disk /srv/salt-images/{{ vm_name }}.qcow2,device=disk,bus=virtio -w bridge=br0,model=virtio,mac={{ args.public_mac }} -w bridge=br1,model=virtio,mac={{ args.private_mac }} --console pty,target_type=serial --graphics none --noautoconsole --import':
  cmd.run:
    - runas: root
    - unless: virsh list --all | grep {{ vm_name }}
    - require: 
      - cmd: copy_{{ vm_name }}_image
          {%- else %}
# if public mac does not exist in pillar, do not attach to br0 (public network)
'virt-install -n {{ vm_name }} --memory {{ args.memory }} --vcpus {{ args.vcpu }} --os-type=linux --os-variant=ubuntu16.04 --virt-type kvm --disk /srv/salt-images/{{ vm_name }}.qcow2,device=disk,bus=virtio -w bridge=br1,model=virtio,mac={{ args.private_mac }} --console pty,target_type=serial --graphics none --noautoconsole --import':
 cmd.run:
    - runas: root
    - unless: virsh list --all | grep {{ vm_name }}
    - require:
      - cmd: copy_{{ vm_name }}_image
          {%- endif %}

# set vm to autostart on boot
'virsh autostart {{ vm_name }}':
  cmd.run:
    - runas: root
    - unless: virsh list --autostart | grep {{ vm_name }}
        {%- endfor %}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
{%- endfor %}
