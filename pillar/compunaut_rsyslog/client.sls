include:
  - compunaut_rsyslog.consul

rsyslog:
{%- for minion, hostname in salt.saltutil.runner('mine.get', tgt='compunaut_rsyslog:enabled:True', fun='network.get_hostname', tgt_type='pillar').items() %}
  target: {{ hostname }}.node.consul
{%- endfor %}
  protocol: udp
