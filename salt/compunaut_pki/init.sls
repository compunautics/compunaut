include:
{%- if pillar.compunaut_salt is defined %}
  {%- if pillar.compunaut_salt.enabled == True %}
  - compunaut_pki.ssh
  - compunaut_pki.ca
  - compunaut_pki.crt
  {%- endif %}
{%- endif %}
  - compunaut_pki.deploy
