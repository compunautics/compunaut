compunaut_consul:
  alerts:
    notif-profiles:
      default: {'Interval': 10,'NotifList': {'log':true,'slack':false,'email':false}}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
    notifiers:
      slack:
        enabled: true
        cluster-name: "Compunaut"
        username: "Compunaut Alerts"
        channel: "\@placeholder"
        url: https://placeholder
      email:
        enabled: true
        cluster-name: "Compunaut"
        sender-alias: "Compunaut Alerts"
        sender-email: "consul-alerts@{{ vars.domain }}"
        receivers: ["placeholder@placeholder.com"]
        one-per-node: true
{%- endfor %}
