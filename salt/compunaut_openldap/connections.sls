manage_compunaut_guacamole_groups:
  ldap.managed:
    - connect_spec:
        url: ldapi:///
        bind:
          dn: "{{ pillar.openldap.rootdn }}"
          password: "{{ pillar.openldap.unencrypted_rootpw }}"
    - entries:
{%- for minion, interfaces in salt['mine.get']('compunaut_vnc:enabled:True', fun='network.interfaces', tgt_type='pillar').iteritems() %}
  {%- if interfaces['ens2'] is not defined %}
    {%- set address = '127.0.0.1' %}
  {%- else %}
    {%- set address = interfaces['ens2']['inet'][0]['address'] %}
  {%- endif %}
      - 'cn={{ minion }},ou=Groups,{{ pillar.openldap.base }}':
        - add:
            cn:
              - {{ minion }}
            objectClass:
              - top
              - guacConfigGroup
            member:
              - cn=compunaut_guacamole,ou=Users,{{ pillar.openldap.base }}
            description:
              - Connection group for {{ minion }}; Assign users to this group to grant access
            guacConfigProtocol:
              - vnc
            guacConfigParameter:
              - hostname={{ address }}
              - port=5901
              - password={{ pillar.openldap.secrets.guac_vnc_password }}
{%- endfor %}
