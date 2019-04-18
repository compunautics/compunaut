manage_repl_config:
  ldap.managed:
    - unless: test -f /etc/ldap/slapd.d/cn\=config/cn\=module\{2\}.ldif
    - connect_spec:
        url: ldapi:///
        bind:
          method: sasl
          mechanism: EXTERNAL
    - entries:
      - 'cn=config':
        - default:
            olcServerID:
{%- for minion, hostname in salt['mine.get']('compunaut_openldap:enabled:True', fun='network.get_hostname', 'pillar').iteritems()|sort %}
  {%- set id = loop.index %}
  {%- for minion, interfaces in salt['mine.get'](hostname, fun='network.interfaces').iteritems() %}
    {%- if interfaces['ens2'] is not defined %}
      {%- set provider = '127.0.0.1' %}
    {%- else %}
      {%- set provider = interfaces['ens2']['inet'][0]['address'] %}
    {%- endif %}
              - "0{{ id }} ldap://{{ provider }}/"
  {%- endfor %}
{%- endfor %}
      - 'cn=module,cn=config':
        - add:
            objectClass: olcModuleList
            olcModulePath: /usr/lib/ldap
            olcModuleLoad:
              - syncprov.la
      - 'olcOverlay=syncprov,olcDatabase={1}mdb,cn=config':
        - replace:
            objectClass:
              - olcOverlayConfig
              - olcSyncProvConfig
            olcOverlay: syncprov
            olcServerID:
      - 'olcDatabase={1}mdb,cn=config':
        - default:
            olcLimits: dn.exact="{{ pillar.openldap.rootdn }}" time.soft=unlimited time.hard=unlimited size.soft=unlimited size.hard=unlimited
            olcSyncRepl:
{%- for minion, hostname in salt['mine.get']('compunaut_openldap:enabled:True', fun='network.get_hostname', 'pillar').iteritems()|sort %}
  {%- set rid = loop.index %}
  {%- for minion, interfaces in salt['mine.get'](hostname, fun='network.interfaces').iteritems() %}
    {%- if interfaces['ens2'] is not defined %}
      {%- set provider = '127.0.0.1' %}
    {%- else %}
      {%- set provider = interfaces['ens2']['inet'][0]['address'] %}
    {%- endif %}
              - rid=00{{ rid }} provider=ldap://{{ provider }}/ binddn="{{ pillar.openldap.rootdn }}" bindmethod=simple credentials={{ pillar.openldap.unencrypted_rootpw }} searchbase="{{ pillar.openldap.base }}" type=refreshOnly retry="5 5 300 5" interval=00:00:00:10 timeout=1
  {%- endfor %}
{%- endfor %}
            olcMirrorMode: "TRUE"
