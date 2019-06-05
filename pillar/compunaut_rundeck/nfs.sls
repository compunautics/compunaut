nfs:
  client:
    enabled: True
    mount:
      var_lib_rundeck_logs:
        path: /var/lib/rundeck/logs/
        fstype: nfs
        device: nfs01-vm.compunaut.net:/srv/rundeck_execution_logs
        opts: "rw,user"
