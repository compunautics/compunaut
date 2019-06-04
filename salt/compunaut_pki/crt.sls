{%- for minion, hostname in salt['mine.get']('*', 'network.get_hostname').iteritems()|sort %}
/srv/salt/compunaut_pki/keys/{{ hostname }}.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/compunaut_pki/keys/{{ hostname }}.csr:
  x509.csr_managed:
    - private_key: /srv/salt/compunaut_pki/keys/{{ hostname }}.key
    - CN: {{ hostname }}.{{ pillar.compunaut.vars.domain }}
    - C: US
    - ST: Texas
    - L: Austin
    - keyUsage: "keyEncipherment,keyAgreement,digitalSignature"
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'

/srv/salt/compunaut_pki/keys/{{ hostname }}.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/compunaut_pki/keys/ca.key
    - signing_cert: /srv/salt/compunaut_pki/keys/ca.crt
    - csr: /srv/salt/compunaut_pki/keys/{{ hostname }}.csr
    - keyUsage: 'keyEncipherment,keyAgreement,digitalSignature'
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'
    - days_valid: 3650
    - days_remaining: 0
    - CN: {{ hostname }}.{{ pillar.compunaut.vars.domain }}
    - C: US
    - ST: Texas
    - L: Austin
{%- endfor %}

{%- for client in salt['pillar.get']('compunaut_pki:openvpn_clients') %}
/srv/salt/compunaut_pki/keys/{{ client }}.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/compunaut_pki/keys/{{ client }}.csr:
  x509.csr_managed:
    - private_key: /srv/salt/compunaut_pki/keys/{{ client }}.key
    - CN: {{ client }}
    - C: US
    - ST: Texas
    - L: Austin
    - keyUsage: "keyEncipherment,keyAgreement,digitalSignature"
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'

/srv/salt/compunaut_pki/keys/{{ client }}.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/compunaut_pki/keys/ca.key
    - signing_cert: /srv/salt/compunaut_pki/keys/ca.crt
    - csr: /srv/salt/compunaut_pki/keys/{{ client }}.csr
    - keyUsage: 'keyEncipherment,keyAgreement,digitalSignature'
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'
    - days_valid: 3650
    - days_remaining: 0
    - CN: {{ client }}
    - C: US
    - ST: Texas
    - L: Austin
{%- endfor %}

/srv/salt/compunaut_pki/keys/compunaut_openldap.service.consul.key:
  x509.private_key_managed:
    - bits: 4096

/srv/salt/compunaut_pki/keys/compunaut_openldap.service.consul.csr:
  x509.csr_managed:
    - private_key: /srv/salt/compunaut_pki/keys/compunaut_openldap.service.consul.key
    - CN: compunaut-openldap.service.consul
    - C: US
    - ST: Texas
    - L: Austin
    - keyUsage: "keyEncipherment,keyAgreement,digitalSignature"
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'

/srv/salt/compunaut_pki/keys/compunaut_openldap.service.consul.crt:
  x509.certificate_managed:
    - signing_private_key: /srv/salt/compunaut_pki/keys/ca.key
    - signing_cert: /srv/salt/compunaut_pki/keys/ca.crt
    - csr: /srv/salt/compunaut_pki/keys/compunaut_openldap.service.consul.csr
    - keyUsage: 'keyEncipherment,keyAgreement,digitalSignature'
    - extendedKeyUsage: 'TLS Web Server Authentication,TLS Web Client Authentication'
    - days_valid: 3650
    - days_remaining: 0
    - CN: compunaut-openldap.service.consul 
    - C: US
    - ST: Texas
    - L: Austin
