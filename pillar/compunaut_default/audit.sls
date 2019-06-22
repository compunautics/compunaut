audit:
  auditctl:
    backlog_limit: 8192
    rules:
      ## Obtained from https://github.com/Neo23x0/auditd/blob/master/audit.rules
      # self auditing
      - -w /var/log/audit/ -k auditlog
      - -w /etc/audit/ -p wa -k auditconfig
      - -w /etc/libaudit.conf -p wa -k auditconfig
      - -w /etc/audisp/ -p wa -k audispconfig
      - -w /sbin/auditctl -p x -k audittools
      - -w /sbin/auditd -p x -k audittools
      # filters
      - -a always,exclude -F msgtype=AVC
      - -a always,exclude -F msgtype=CWD
      - -a always,exclude -F msgtype=EOE
      - -a never,user -F subj_type=crond_t
      - -a exit,never -F subj_type=crond_t
      - -a never,exit -F arch=b64 -S adjtimex -F auid=unset -F uid=_chrony -F subj_type=chronyd_t
      - -a always,exclude -F msgtype=CRYPTO_KEY_USER
      - -a exit,never -F arch=b32 -S fork -F success=0 -F path=/usr/lib/vmware-tools -F subj_type=initrc_t -F exit=-2
      - -a exit,never -F arch=b64 -S fork -F success=0 -F path=/usr/lib/vmware-tools -F subj_type=initrc_t -F exit=-2
      - -a exit,never -F arch=b32 -F dir=/dev/shm -k sharedmemaccess
      - -a exit,never -F arch=b64 -F dir=/dev/shm -k sharedmemaccess
      - -a exit,never -F arch=b32 -F dir=/var/lock/lvm -k locklvm
      - -a exit,never -F arch=b64 -F dir=/var/lock/lvm -k locklvm
      # rules
      - -a exit,always -F arch=b64 -F euid=0 -S execve -k rootcmd
      - -a exit,always -F arch=b32 -F euid=0 -S execve -k rootcmd
      - -w /usr/bin/dpkg -p x -k software_mgmt
      - -w /usr/bin/apt-add-repository -p x -k software_mgmt
      - -w /usr/bin/apt-get -p x -k software_mgmt
      - -w /usr/bin/aptitude -p x -k software_mgmt
      - -w /etc/sysctl.conf -p wa -k sysctl
      - -w /etc/localtime -p wa -k localtime
      - -w /etc/cron.allow -p wa -k cron
      - -w /etc/cron.deny -p wa -k cron
      - -w /etc/cron.d/ -p wa -k cron
      - -w /etc/cron.daily/ -p wa -k cron
      - -w /etc/cron.hourly/ -p wa -k cron
      - -w /etc/cron.monthly/ -p wa -k cron
      - -w /etc/cron.weekly/ -p wa -k cron
      - -w /etc/crontab -p wa -k cron
      - -w /var/spool/cron/crontabs/ -k cron
      - -w /etc/group -p wa -k etcgroup
      - -w /etc/passwd -p wa -k etcpasswd
      - -w /etc/gshadow -k etcgroup
      - -w /etc/shadow -k etcpasswd
      - -w /etc/security/opasswd -k opasswd
      - -w /etc/sudoers -p wa -k actions
      - -w /usr/bin/passwd -p x -k passwd_modification
      - -w /usr/sbin/groupadd -p x -k group_modification
      - -w /usr/sbin/groupmod -p x -k group_modification
      - -w /usr/sbin/addgroup -p x -k group_modification
      - -w /usr/sbin/useradd -p x -k user_modification
      - -w /usr/sbin/usermod -p x -k user_modification
      - -w /usr/sbin/adduser -p x -k user_modification
      - -w /etc/login.defs -p wa -k login
      - -w /etc/securetty -p wa -k login
      - -w /var/log/faillog -p wa -k login
      - -w /var/log/lastlog -p wa -k login
      - -w /var/log/tallylog -p wa -k login
      - -a always,exit -F arch=b32 -S sethostname -S setdomainname -k network_modifications
      - -a always,exit -F arch=b64 -S sethostname -S setdomainname -k network_modifications
      - -w /etc/hosts -p wa -k network_modifications
      - -w /etc/network/ -p wa -k network
      - -w /etc/inittab -p wa -k init
      - -w /etc/init.d/ -p wa -k init
      - -w /etc/init/ -p wa -k init
      - -w /etc/ssh/sshd_config -k sshd
      - -w /bin/systemctl -p x -k systemd 
      - -w /etc/systemd/ -p wa -k systemd
      - -a exit,always -F arch=b64 -S open -F dir=/etc -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/bin -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/sbin -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/usr/bin -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/usr/sbin -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/var -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/home -F success=0 -k unauthedfileaccess
      - -a exit,always -F arch=b64 -S open -F dir=/srv -F success=0 -k unauthedfileaccess
      - -w /bin/su -p x -k priv_esc
      - -w /usr/bin/sudo -p x -k priv_esc
      - -w /etc/sudoers -p rw -k priv_esc
      - -w /sbin/shutdown -p x -k power
      - -w /sbin/poweroff -p x -k power
      - -w /sbin/reboot -p x -k power
      - -w /sbin/halt -p x -k power
      - -a always,exit -F arch=b32 -S chmod -F auid>=500 -F auid!=4294967295 -k perm_mod
      - -a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
      - -a always,exit -F arch=b64 -S chmod  -F auid>=500 -F auid!=4294967295 -k perm_mod
      - -a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 -k perm_mod
      - -a always,exit -F arch=b32 -S all -k 32bit_api
      - -w /usr/bin/whoami -p x -k recon
      - -w /etc/issue -p r -k recon
      - -w /etc/hostname -p r -k recon
      - -w /usr/bin/wget -p x -k susp_activity
      - -w /usr/bin/curl -p x -k susp_activity
      - -w /usr/bin/base64 -p x -k susp_activity
      - -w /bin/nc -p x -k susp_activity
      - -w /bin/netcat -p x -k susp_activity
      - -w /usr/bin/ssh -p x -k susp_activity
      - -w /sbin/iptables -p x -k sbin_susp 
      - -w /sbin/ifconfig -p x -k sbin_susp
      - -w /usr/sbin/tcpdump -p x -k sbin_susp
      - -w /usr/sbin/traceroute -p x -k sbin_susp
      - -a always,exit -F arch=b32 -S ptrace -k tracing
      - -a always,exit -F arch=b64 -S ptrace -k tracing
      - -a always,exit -F arch=b32 -S ptrace -F a0=0x4 -k code_injection
      - -a always,exit -F arch=b64 -S ptrace -F a0=0x4 -k code_injection
      - -a always,exit -F arch=b32 -S ptrace -F a0=0x5 -k data_injection
      - -a always,exit -F arch=b64 -S ptrace -F a0=0x5 -k data_injection
      - -a always,exit -F arch=b32 -S ptrace -F a0=0x6 -k register_injection
      - -a always,exit -F arch=b64 -S ptrace -F a0=0x6 -k register_injection
      - -a always,exit -F dir=/home -F uid=0 -F auid>=1000 -F auid!=4294967295 -C auid!=obj_uid -k power_abuse
      - -a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k file_access
      - -a always,exit -F arch=b32 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k file_access
      - -a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k file_access
      - -a always,exit -F arch=b64 -S creat -S open -S openat -S open_by_handle_at -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k file_access
