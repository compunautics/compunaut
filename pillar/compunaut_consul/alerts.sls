### Please refer to https://github.com/AcalephStorage/consul-alerts for documentation on configuring consul-alerts
compunaut_consul:
  alerts:
    notif_profiles:
      default: 
        Interval: 10
        NotifList:
          log: true
          slack: false
          email: false
    notif_selection:
      status:
        warning: default
        critical: default
    notifiers:
      slack:
        enabled: true
        detailed: true
        cluster-name: "Compunaut"
        username: "Compunaut_Alerts"
        channel: "\\\\#placeholder"
        url: https://placeholder
        icon-url: https://avatars1.githubusercontent.com/u/41558985
      email:
        enabled: true
        cluster-name: "Compunaut"
        sender-alias: "Compunaut_Alerts"
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
        sender-email: "consul-alerts@{{ vars.domain }}"
{%- endfor %}
        receivers:
          - placeholder@placeholder.com
        one-per-node: true
