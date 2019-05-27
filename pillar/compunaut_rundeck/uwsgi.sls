uwsgi:
  applications:
    managed:
      compunaut_print_ops.ini:
        enabled: True
        config:
          - plugins: 'cgi'
            http: '127.0.0.1:8080'
            http-modifier1: '9'
            chdir: '/usr/lib/cgi-bin'
            cgi: '/=/usr/lib/cgi-bin'
            cgi-helper: '.py=python'
            cgi-allowed-ext: '.py'
            uid: 'rundeck'
            gid: 'rundeck'