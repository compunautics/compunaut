{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    control.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/standard.tmpl
      interface: '*'
      port: '8080'
      ServerAdmin: mission_control@{{ vars.domain }}
      DocumentRoot: /opt/mission_control
      Directory:
        default:
          Options: -Indexes +FollowSymLinks
          Require: all granted
          AllowOverride: None
{%- endfor %}
