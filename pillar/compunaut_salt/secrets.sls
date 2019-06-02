{%- set id = grains['server_id'] %}
compunaut:
  secrets:
    gitlab:
{%- set gitlab_root_token = salt['cmd.shell']('echo '+id|string+' | sha384sum | cut -d- -f1') %}
{%- set gitlab_admin_password = salt['cmd.shell']('echo '+id|string+' | sha512sum | cut -d- -f1' ) %} # edit this var to set a new password
{%- set gitlab_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set gitlab_crypt_admin_password = salt['cmd.shell']("openssl passwd -1 -salt "+gitlab_crypt_salt+" "+gitlab_admin_password+" 2> /dev/null") %}
      gitlab_admin_password: "{CRYPT}{{ gitlab_crypt_admin_password }}"
      gitlab_admin_unencrypted_password: "{{ gitlab_admin_password }}"
      gitlab_admin_user: "compunaut_gitlab"
      gitlab_root_token: "{{ gitlab_root_token }}" 

    grafana:
{%- set grafana_db_password = salt['cmd.shell']('echo '+id|string+' | sha256sum | cut -d- -f1' ) %}
{%- set grafana_admin_password = salt['cmd.shell']('echo '+id|string+' | sha224sum | cut -d- -f1' ) %} # edit this var to set a new password
{%- set grafana_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set grafana_crypt_admin_password = salt['cmd.shell']("openssl passwd -1 -salt "+grafana_crypt_salt+" "+grafana_admin_password+" 2> /dev/null") %}
      grafana_admin_password: "{CRYPT}{{ grafana_crypt_admin_password }}"
      grafana_admin_user: "compunaut_grafana"
      grafana_database_password: "{{ grafana_db_password }}"
      grafana_unencrypted_admin_password: "{{ grafana_admin_password }}"

    guacamole:
{%- set guac_database_password = salt['cmd.shell']('echo '+id|string+' | sha384sum | sha512sum | cut -d- -f1') %}
{%- set guac_admin_password = salt['cmd.shell']('echo '+id|string+' | sha512sum | sha384sum | cut -d- -f1' ) %} # edit this var to set a new password
{%- set guac_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set guac_crypt_admin_password = salt['cmd.shell']("openssl passwd -1 -salt "+guac_crypt_salt+" "+guac_admin_password+" 2> /dev/null") %}
{%- set guac_vnc_password = salt['cmd.shell']('echo '+id|string+' | md5sum | cut -d- -f1 | head -c8') %}
      guac_admin_password: "{CRYPT}{{ guac_crypt_admin_password }}"
      guac_admin_user: "compunaut_guacamole"
      guac_database_password: "{{ guac_database_password }}"
      guac_unencrypted_admin_password: "{{ guac_admin_password }}"
      guac_vnc_password: "{{ guac_vnc_password }}"
    
    keepalived:
{%- set keepalived_auth_pass = salt['cmd.shell']('date +%s | sha256sum | cut -d- -f1') %}
      keepalived_auth_pass: "{{ keepalived_auth_pass }}"

    octoprint:
{%- set octoprint_api_key = salt['cmd.shell']('echo '+id|string+' | sha512sum | cut -d- -f1 | head -c33') %}
      octoprint_api_key: "{{ octoprint_api_key }}"

    openldap:
{%- set ldap_rootpw = salt['cmd.shell']("echo "+id|string+" | sha1sum | cut -d- -f1") %}
{%- set ldap_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set ldap_crypt_rootpw = salt['cmd.shell']("openssl passwd -1 -salt "+ldap_crypt_salt+" "+ldap_rootpw+" 2> /dev/null") %}
      ldap_base: "dc=compunaut,dc=net"
      ldap_crypt_salt: "{{ ldap_crypt_salt }}"
      ldap_rootdn: "cn=compunaut,dc=compunaut,dc=net"
      ldap_rootpw: "{CRYPT}{{ ldap_crypt_rootpw }}"
      ldap_unencrypted_rootpw: "{{ ldap_rootpw }}"

    openvpn:
{%- set openvpn_management_password = salt['cmd.shell']('echo '+id|string+' | sha1sum | cut -d- -f1') %}
      openvpn_management_password: "{{ openvpn_management_password }}"

    rundeck:
{%- set rundeck_uuid = salt['cmd.shell']('uuidgen') %}
{%- set rundeck_db_password = salt['cmd.shell']('echo '+id|string+' | sha256sum | sha1sum | cut -d- -f1' ) %}
{%- set rundeck_admin_password = salt['cmd.shell']("echo "+id|string+" | sha1sum | sha256sum | cut -d- -f1") %} # edit this var to set a new password
{%- set rundeck_crypt_salt = salt['cmd.shell']("head /dev/urandom | tr -dc A-Za-z0-9 | head -c4") %}
{%- set rundeck_encrypted_password = salt['cmd.shell']("openssl passwd -1 -salt "+rundeck_crypt_salt+" "+rundeck_admin_password+" 2> /dev/null") %}
      rundeck_admin_password: "{CRYPT}{{ rundeck_encrypted_password }}"
      rundeck_admin_unencrypted_password: "{{ rundeck_admin_password }}"
      rundeck_admin_user: "compunaut_rundeck"
      rundeck_database_password: "{{ rundeck_db_password }}"
      rundeck_uuid: "{{ rundeck_uuid }}"
