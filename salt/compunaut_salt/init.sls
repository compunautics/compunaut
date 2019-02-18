include:
  - compunaut_salt.minion
{%- if pillar.compunaut_salt is defined %}
  {%- if pillar.compunaut_salt.enabled == True %}
  - compunaut_salt.master
  {%- endif %}
{%- endif %}
