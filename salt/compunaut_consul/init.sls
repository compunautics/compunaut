include:
  - consul
  - compunaut_consul.checks
{%- if pillar.compunaut_consul is defined %}
  {%- if pillar.compunaut_consul.server is defined %}
    {%- if pillar.compunaut_consul.server.enabled == 'True' %}
  - compunaut_consul.apache
    {%- endif %}
  {%- endif %}
{%- endif %}

