"for vm in $(virsh list --all | grep -P '\\d' | awk '{print $2}'); do virsh destroy ${vm}; done":
  cmd.run

"for vm in $(virsh list --all | grep -P '\\d' | awk '{print $2}'); do rm -fv /srv/salt-images/${vm}.qcow2; done":
  cmd.run

"for vm in $(virsh list --all | grep -P '\\d' | awk '{print $2}'); do virsh undefine ${vm}; done":
  cmd.run

"for net in $(virsh net-list --all | grep -P '\\d' | awk '{print $1}'); do virsh net-destroy ${net}; done":
  cmd.run

"for net in $(virsh net-list --all | grep -P '\\d' | awk '{print $1}'); do virsh net-undefine ${net}; done":
  cmd.run
