{%- set short_local_minion = grains['host'] %}
{%- for minion, vars in salt.saltutil.runner('mine.get', tgt='compunaut_salt:enabled:True', fun='get_vars', tgt_type='pillar').items() %}
apache:
  manage_service_states: True
  sites:
    443-{{ short_local_minion }}.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: {{ short_local_minion }}.{{ vars.domain }}
      ServerAlias: {{ short_local_minion }}.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/compunaut_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_octoprint:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:5000/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:5000/'
    443-webcam.{{ short_local_minion }}.{{ vars.domain }}:
      enabled: True
      template_file: salt://apache/vhosts/proxy.tmpl
      ServerName: webcam.{{ short_local_minion }}.{{ vars.domain }}
      ServerAlias: webcam.{{ short_local_minion }}.{{ vars.domain }}
      interface: '*'
      port: '443'
      SSLCertificateFile: /etc/ssl/private/compunaut_pki.pem
      ProxyRequests: 'Off'
      ProxyPreserveHost: 'On'
      ProxyRoute:
        route_to_local_octoprint:
          ProxyPassSource: '/'
          ProxyPassTarget: 'http://localhost:8081/'
          ProxyPassTargetOptions: 'connectiontimeout=10 timeout=90'
          ProxyPassReverseSource: '/'
          ProxyPassReverseTarget: 'http://localhost:8081/'
{%- endfor %}
