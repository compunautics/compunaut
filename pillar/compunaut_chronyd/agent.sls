chrony:
  ntpservers:
    - '0.us.pool.ntp.org'
    - '1.us.pool.ntp.org'
    - '2.us.pool.ntp.org'
    - '3.us.pool.ntp.org'
  options: "iburst"
  otherparams:
    - initstepslew 5 0.us.pool.ntp.org 1.us.pool.ntp.org 2.us.pool.ntp.org 3.us.pool.ntp.org
