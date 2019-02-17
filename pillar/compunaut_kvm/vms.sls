### NOTE: The VM names you give below will be concat'd with the global domain in vars to create the complete vm hostname
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
compunaut_kvm:
  image_source:
    base_image: http://images.compunaut.io/images/compunaut-minion.qcow2
    source_hash: 30791db07b1c8418ff36398b6b0a817ff7fdadd6f770ab7552501dd7fa99be99
  salt01:
    vms:
      consul01-vm:
        public_mac: 52:54:00:b3:72:a5
        private_mac: 52:54:00:16:ec:00
        private_ip: {{ vars.private_net }}.11
        vcpu: 2
        memory: 2048
      db01-vm:
        public_mac: 52:54:00:db:6a:90
        private_mac: 52:54:00:66:21:64
        private_ip: {{ vars.private_net }}.12
        vcpu: 4
        memory: 4096
        disk: 200
  kvm02:
    vms:
      consul02-vm:
        public_mac: 52:54:00:11:eb:24
        private_mac: 52:54:00:16:ec:00
        private_ip: {{ vars.private_net }}.21
        vcpu: 2
        memory: 2048
      db02-vm:
        public_mac: 52:54:00:84:c2:94
        private_mac: 52:54:00:c7:61:ba
        private_ip: {{ vars.private_net }}.22
        vcpu: 4
        memory: 4096
        disk: 200
      ldap01-vm:
        public_mac: 52:54:00:bd:5b:4e
        private_mac: 52:54:00:f1:6d:7f
        private_ip: {{ vars.private_net }}.23
        vcpu: 2
        memory: 2048
      netboot01-vm:
        public_mac: 52:54:00:8e:80:d5
        private_mac: 52:54:00:7e:f5:3b
        private_ip: {{ vars.private_net }}.24
        vcpu: 8
        memory: 8192
        disk: 500
      monitor01-vm:
        public_mac: 52:54:00:0a:07:4f
        private_mac: 52:54:00:b2:dd:f9
        private_ip: {{ vars.private_net }}.25
        vcpu: 2
        memory: 2048
      proxy01-vm:
        public_mac: 52:54:00:6b:77:13
        private_mac: 52:54:00:3f:56:05
        private_ip: {{ vars.private_net }}.26
        vcpu: 2
        memory: 2048
      rundeck01-vm:
        public_mac: 52:54:00:a3:c2:75
        private_mac: 52:54:00:22:e3:81
        private_ip: {{ vars.private_net }}.27
        vcpu: 4
        memory: 4096
      vpn01-vm:
        public_mac: 52:54:00:6b:77:11
        private_mac: 52:54:00:15:72:01
        private_ip: {{ vars.private_net }}.28
        vcpu: 2
        memory: 2048
  kvm03:
    vms:
      consul03-vm:
        public_mac: 52:54:00:03:e6:6e
        private_mac: 52:54:00:2a:ac:20
        private_ip: {{ vars.private_net }}.31
        vcpu: 2
        memory: 2048
      db03-vm:
        public_mac: 52:54:00:f6:81:b5
        private_mac: 52:54:00:86:4b:83
        private_ip: {{ vars.private_net }}.32
        vcpu: 4
        memory: 4096
        disk: 200
      gitlab01-vm:
        public_mac: 52:54:00:cf:22:ee
        private_mac: 52:54:00:a6:ba:16
        private_ip: {{ vars.private_net }}.33
        vcpu: 8
        memory: 8192
      ldap02-vm:
        public_mac: 52:54:00:71:36:73
        private_mac: 52:54:00:63:9c:4
        private_ip: {{ vars.private_net }}.34
        vcpu: 2
        memory: 2048
      monitor02-vm:
        public_mac: 52:54:00:c9:be:7a
        private_mac: 52:54:00:61:53:bf
        private_ip: {{ vars.private_net }}.35
        vcpu: 2
        memory: 2048
      proxy02-vm:
        public_mac: 52:54:00:6b:77:14
        private_mac: 52:54:00:1c:42:e4
        private_ip: {{ vars.private_net }}.36
        vcpu: 2
        memory: 2048
      rundeck02-vm:
        public_mac: 52:54:00:2e:86:7b
        private_mac: 52:54:00:81:e2:79
        private_ip: {{ vars.private_net }}.37
        vcpu: 4
        memory: 4096
      vpn02-vm:
        public_mac: 52:54:00:6b:77:12
        private_mac: 52:54:00:1c:c9:39
        private_ip: {{ vars.private_net }}.38
        vcpu: 2
        memory: 2048
{%- endfor %}
