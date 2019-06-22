audit:
  auditctl:
    backlog_limit: 8192
    rules:
      ## Obtained from https://github.com/Neo23x0/auditd/blob/master/audit.rules and related links
      # filters
      - -a always,exclude -F msgtype=AVC
      - -a always,exclude -F msgtype=CWD
      - -a always,exclude -F msgtype=EOE
      - -a never,user -F subj_type=crond_t
      - -a exit,never -F subj_type=crond_t
      - -a never,exit -F arch=b64 -S adjtimex -F auid=unset -F uid=_chrony -F subj_type=chronyd_t
      - -a always,exclude -F msgtype=CRYPTO_KEY_USER
      - -a exit,never -F arch=b64 -F dir=/dev/shm -k sharedmemaccess
      - -a exit,never -F arch=b64 -F dir=/var/lock/lvm -k locklvm
      # self auditing
      - -a always,exit -F dir=/var/log/audit/ -F perm=r -F auid>=1000 -F auid!=unset -F key=access-audit-trail
      - -a always,exit -F path=/usr/sbin/ausearch -F perm=x -F key=access-audit-trail
      - -a always,exit -F path=/usr/sbin/aureport -F perm=x -F key=access-audit-trail
      - -a always,exit -F path=/usr/sbin/aulast -F perm=x -F key=access-audit-trail
      - -a always,exit -F path=/usr/sbin/aulastlogin -F perm=x -F key=access-audit-trail
      - -a always,exit -F path=/usr/sbin/auvirt -F perm=x -F key=access-audit-trail
      - -a always,exit -F dir=/var/log/audit/ -F perm=wa -F key=modification-audit
      - -w /etc/audit/ -p wa -k auditconfig
      - -w /etc/libaudit.conf -p wa -k auditconfig
      - -w /etc/audisp/ -p wa -k audispconfig
      - -w /sbin/auditctl -p x -k audittools
      - -w /sbin/auditd -p x -k audittools
      # software installation
      - -w /usr/bin/dpkg -p x -k software_mgmt
      - -w /usr/bin/apt-add-repository -p x -k software_mgmt
      - -w /usr/bin/apt-get -p x -k software_mgmt
      - -w /usr/bin/aptitude -p x -k software_mgmt
      # time
      -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=time-change
      -a always,exit -F arch=b64 -S clock_settime -F a0=0x0 -F key=time-change
      -w /etc/localtime -p wa -k time-change
      # priv escalations
      - -a always,exit -F arch=b64 -S setuid -F a0=0 -F exe=/usr/bin/su -F key=elevated-privs-session
      - -a always,exit -F arch=b64 -S setresuid -F a0=0 -F exe=/usr/bin/sudo -F key=elevated-privs-session
      - -a always,exit -F arch=b64 -S execve -C uid!=euid -F euid=0 -F key=elevated-privs-setuid
      - -w /bin/su -p x -k priv_esc
      - -w /usr/bin/sudo -p x -k priv_esc
      # accounts
      - -a always,exit -F path=/etc/group -F perm=wa -F key=accounts
      - -a always,exit -F path=/etc/passwd -F perm=wa -F key=accounts
      - -a always,exit -F path=/etc/gshadow -F perm=wa -F key=accounts
      - -a always,exit -F path=/etc/shadow -F perm=wa -F key=accounts
      - -a always,exit -F path=/etc/security/opasswd -F perm=wa -F key=accounts
      - -w /etc/sudoers -p wa -k accounts

