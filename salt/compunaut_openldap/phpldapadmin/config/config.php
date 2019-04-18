<?php
/** THIS FILE IS MANAGED BY SALTSTACK **
 ** Changes will be overwritten!
 **/

/**
 * The phpLDAPadmin config file
 * See: http://phpldapadmin.sourceforge.net/wiki/index.php/Config.php
 */

/*********************************************
 * Useful important configuration overrides  *
 *********************************************/

/* If you are asked to put PLA in debug mode, this is how you do it: */
#  $config->custom->debug['level'] = 255;
#  $config->custom->debug['syslog'] = true;
#  $config->custom->debug['file'] = '/tmp/pla_debug.log';

/* phpLDAPadmin can encrypt the content of sensitive cookies if you set this
   to a big random string. */
// $config->custom->session['blowfish'] = null;

/* The language setting. If you set this to 'auto', phpLDAPadmin will attempt
   to determine your language automatically.
   If PLA doesnt show (all) strings in your language, then you can do some
   translation at http://translations.launchpad.net/phpldapadmin and download
   the translation files, replacing those provided with PLA.
   (We'll pick up the translations before making the next release too!) */
// $config->custom->appearance['language'] = 'auto';

/* The temporary storage directory where we will put jpegPhoto data
   This directory must be readable and writable by your web server. */
// $config->custom->jpeg['tmpdir'] = '/tmp';     // Example for Unix systems

/* PHP script timeout control. If php runs longer than this many seconds then
   PHP will stop with an Maximum Execution time error. Increase this value from
   the default if queries to your LDAP server are slow. The default is either
   30 seconds or the setting of max_exection_time if this is null. */
// $config->custom->session['timelimit'] = 30;

/* Our local timezone
   This is to make sure that when we ask the system for the current time, we
   get the right local time. If this is not set, all time() calculations will
   assume UTC if you have not set PHP date.timezone. */
// $config->custom->appearance['timezone'] = null;
$config->custom->appearance['timezone'] = 'America/Chicago';

/*********************************************
 * Commands                                  *
 *********************************************/

/* Command availability ; if you don't authorize a command the command
   links will not be shown and the command action will not be permitted.
   For better security, set also ACL in your ldap directory. */
/*
$config->custom->commands['cmd'] = array(
        'entry_internal_attributes_show' => true,
        'entry_refresh' => true,
        'oslinks' => true,
        'switch_template' => true
);

$config->custom->commands['script'] = array(
        'add_attr_form' => true,
        'add_oclass_form' => true,
        'add_value_form' => true,
        'collapse' => true,
        'compare' => true,
        'compare_form' => true,
        'copy' => true,
        'copy_form' => true,
        'create' => true,
        'create_confirm' => true,
        'delete' => true,
        'delete_attr' => true,
        'delete_form' => true,
        'draw_tree_node' => true,
        'expand' => true,
        'export' => true,
        'export_form' => true,
        'import' => true,
        'import_form' => true,
        'login' => true,
        'logout' => true,
        'login_form' => true,
        'mass_delete' => true,
        'mass_edit' => true,
        'mass_update' => true,
        'modify_member_form' => true,
        'monitor' => true,
        'purge_cache' => true,
        'query_engine' => true,
        'rename' => true,
        'rename_form' => true,
        'rdelete' => true,
        'refresh' => true,
        'schema' => true,
        'server_info' => true,
        'show_cache' => true,
        'template_engine' => true,
        'update_confirm' => true,
        'update' => true
);
*/

/*********************************************
 * Appearance                                *
 *********************************************/

/* If you want to choose the appearance of the tree, specify a class name which
   inherits from the Tree class. */
// $config->custom->appearance['tree'] = 'AJAXTree';
#  $config->custom->appearance['tree'] = 'HTMLTree';

/* Just show your custom templates. */
// $config->custom->appearance['custom_templates_only'] = false;

/* Disable the default template. */
// $config->custom->appearance['disable_default_template'] = false;

/* Hide the warnings for invalid objectClasses/attributes in templates. */
$config->custom->appearance['hide_template_warning'] = true;

/* Set to true if you would like to hide header and footer parts. */
// $config->custom->appearance['minimalMode'] = false;

/* Configure what objects are shown in left hand tree */
// $config->custom->appearance['tree_filter'] = '(objectclass=*)';

/* The height and width of the tree. If these values are not set, then
   no tree scroll bars are provided. */
// $config->custom->appearance['tree_height'] = null;
#  $config->custom->appearance['tree_height'] = 600;
// $config->custom->appearance['tree_width'] = null;
#  $config->custom->appearance['tree_width'] = 250;

/* Confirm create and update operations, allowing you to review the changes
   and optionally skip attributes during the create/update operation. */
$config->custom->confirm['create'] = true;
$config->custom->confirm['update'] = false;

/* Confirm copy operations, and treat them like create operations. This allows
   you to edit the attributes (thus changing any that might conflict with
   uniqueness) before creating the new entry. */
$config->custom->confirm['copy'] = true;

/*********************************************
 * User-friendly attribute translation       *
 *********************************************/

/* Use this array to map attribute names to user friendly names. For example, if
   you don't want to see "facsimileTelephoneNumber" but rather "Fax". */
// $config->custom->appearance['friendly_attrs'] = array();
$config->custom->appearance['friendly_attrs'] = array(
	'facsimileTelephoneNumber' => 'Fax',
	'gid'                      => 'Group',
	'mail'                     => 'Email',
	'telephoneNumber'          => 'Telephone',
	'uid'                      => 'User Name',
	'userPassword'             => 'Password'
);

/*********************************************
 * Hidden attributes                         *
 *********************************************/

/* You may want to hide certain attributes from being edited. If you want to
   hide attributes from the user, you should use your LDAP servers ACLs.
   NOTE: The user must be able to read the hide_attrs_exempt entry to be
   excluded. */
// $config->custom->appearance['hide_attrs'] = array();
#  $config->custom->appearance['hide_attrs'] = array('objectClass');

/* Members of this list will be exempt from the hidden attributes. */
// $config->custom->appearance['hide_attrs_exempt'] = null;
#  $config->custom->appearance['hide_attrs_exempt'] = 'cn=PLA UnHide,ou=Groups,c=AU';

/*********************************************
 * Read-only attributes                      *
 *********************************************/

/* You may want to phpLDAPadmin to display certain attributes as read only,
   meaning that users will not be presented a form for modifying those
   attributes, and they will not be allowed to be modified on the "back-end"
   either. You may configure this list here:
   NOTE: The user must be able to read the readonly_attrs_exempt entry to be
   excluded. */
// $config->custom->appearance['readonly_attrs'] = array();

/* Members of this list will be exempt from the readonly attributes. */
// $config->custom->appearance['readonly_attrs_exempt'] = null;
#  $config->custom->appearance['readonly_attrs_exempt'] = 'cn=PLA ReadWrite,ou=Groups,c=AU';

/*********************************************
 * Group attributes                          *
 *********************************************/

/* Add "modify group members" link to the attribute. */
// $config->custom->modify_member['groupattr'] = array('member','uniqueMember','memberUid');

/* Configure filter for member search. This only applies to "modify group members" feature */
// $config->custom->modify_member['filter'] = '(objectclass=Person)';

/* Attribute that is added to the group member attribute. */
// $config->custom->modify_member['attr'] = 'dn';

/* For Posix attributes */
// $config->custom->modify_member['posixattr'] = 'uid';
// $config->custom->modify_member['posixfilter'] = '(uid=*)';
// $config->custom->modify_member['posixgroupattr'] = 'memberUid';

/*********************************************
 * Support for attrs display order           *
 *********************************************/

/* Use this array if you want to have your attributes displayed in a specific
   order. You can use default attribute names or their fridenly names.
   For example, "sn" will be displayed right after "givenName". All the other
   attributes that are not specified in this array will be displayed after in
   alphabetical order. */
// $config->custom->appearance['attr_display_order'] = array();
#  $config->custom->appearance['attr_display_order'] = array(
#   'givenName',
#   'sn',
#   'cn',
#   'displayName',
#   'uid',
#   'uidNumber',
#   'gidNumber',
#   'homeDirectory',
#   'mail',
#   'userPassword'
#  );

/*********************************************
 * Define your LDAP servers in this section  *
 *********************************************/

$servers = new Datastore();

/* $servers->NewServer('ldap_pla') must be called before each new LDAP server
   declaration. */
$servers->newServer('ldap_pla');

/* A convenient name that will appear in the tree viewer and throughout
   phpLDAPadmin to identify this LDAP server to users. */
$servers->setValue('server','name','Compunaut OpenLDAP');

/* Examples:
   'ldap.example.com',
   'ldaps://ldap.example.com/',
   'ldapi://%2fusr%local%2fvar%2frun%2fldapi'
           (Unix socket at /usr/local/var/run/ldap) */
$servers->setValue('server','host','compunaut_openldap.service.consul');

/* The port your LDAP server listens on (no quotes). 389 is standard. */
// $servers->setValue('server','port',389);

/* Array of base DNs of your LDAP server. Leave this blank to have phpLDAPadmin
   auto-detect it for you. */
$servers->setValue('server','base',array('{{ pillar.openldap.base }}'));

/* Five options for auth_type:
   1. 'cookie': you will login via a web form, and a client-side cookie will
      store your login dn and password.
   2. 'session': same as cookie but your login dn and password are stored on the
      web server in a persistent session variable.
   3. 'http': same as session but your login dn and password are retrieved via
      HTTP authentication.
   4. 'config': specify your login dn and password here in this config file. No
      login will be required to use phpLDAPadmin for this server.
   5. 'sasl': login will be taken from the webserver's kerberos authentication.
      Currently only GSSAPI has been tested (using mod_auth_kerb).

   Choose wisely to protect your authentication information appropriately for
   your situation. If you choose 'cookie', your cookie contents will be
   encrypted using blowfish and the secret your specify above as
   session['blowfish']. */
$servers->setValue('login','auth_type','cookie');

/* The DN of the user for phpLDAPadmin to bind with. For anonymous binds or
   'cookie','session' or 'sasl' auth_types, LEAVE THE LOGIN_DN AND LOGIN_PASS
   BLANK. If you specify a login_attr in conjunction with a cookie or session
   auth_type, then you can also specify the bind_id/bind_pass here for searching
   the directory for users (ie, if your LDAP server does not allow anonymous
   binds. */
$servers->setValue('login','bind_id','');
#  $servers->setValue('login','bind_id','cn=Manager,dc=example,dc=com');

/* Your LDAP password. If you specified an empty bind_id above, this MUST also
   be blank. */
// $servers->setValue('login','bind_pass','');
#  $servers->setValue('login','bind_pass','secret');

/* Use TLS (Transport Layer Security) to connect to the LDAP server. */
// $servers->setValue('server','tls',false);

/************************************
 *      SASL Authentication         *
 ************************************/

/* Enable SASL authentication LDAP SASL authentication requires PHP 5.x
   configured with --with-ldap-sasl=DIR. If this option is disabled (ie, set to
   false), then all other sasl options are ignored. */
// $servers->setValue('login','auth_type','sasl');

/* SASL auth mechanism */
// $servers->setValue('sasl','mech','GSSAPI');

/* SASL authentication realm name */
// $servers->setValue('sasl','realm','');
#  $servers->setValue('sasl','realm','EXAMPLE.COM');

/* SASL authorization ID name
   If this option is undefined, authorization id will be computed from bind DN,
   using authz_id_regex and authz_id_replacement. */
// $servers->setValue('sasl','authz_id', null);

/* SASL authorization id regex and replacement
   When authz_id property is not set (default), phpLDAPAdmin will try to
   figure out authorization id by itself from bind distinguished name (DN).

   This procedure is done by calling preg_replace() php function in the
   following way:

   $authz_id = preg_replace($sasl_authz_id_regex,$sasl_authz_id_replacement,
    $bind_dn);

   For info about pcre regexes, see:
   - pcre(3), perlre(3)
   - http://www.php.net/preg_replace */
// $servers->setValue('sasl','authz_id_regex',null);
// $servers->setValue('sasl','authz_id_replacement',null);
#  $servers->setValue('sasl','authz_id_regex','/^uid=([^,]+)(.+)/i');
#  $servers->setValue('sasl','authz_id_replacement','$1');

/* SASL auth security props.
   See http://beepcore-tcl.sourceforge.net/tclsasl.html#anchor5 for explanation. */
// $servers->setValue('sasl','props',null);

/* Default password hashing algorithm. One of md5, ssha, sha, md5crpyt, smd5,
   blowfish, crypt or leave blank for now default algorithm. */
// $servers->setValue('appearance','password_hash_custom','md5');

/* If you specified 'cookie' or 'session' as the auth_type above, you can
   optionally specify here an attribute to use when logging in. If you enter
   'uid' and login as 'dsmith', phpLDAPadmin will search for (uid=dsmith)
   and log in as that user.
   Leave blank or specify 'dn' to use full DN for logging in. Note also that if
   your LDAP server requires you to login to perform searches, you can enter the
   DN to use when searching in 'bind_id' and 'bind_pass' above. */
// $servers->setValue('login','attr','dn');

/* Base DNs to used for logins. If this value is not set, then the LDAP server
   Base DNs are used. */
// $servers->setValue('login','base',array());

/* If 'login,attr' is used above such that phpLDAPadmin will search for your DN
   at login, you may restrict the search to a specific objectClasses. EG, set this
   to array('posixAccount') or array('inetOrgPerson',..), depending upon your
   setup. */
// $servers->setValue('login','class',array());

/* If you specified something different from 'dn', for example 'uid', as the
   login_attr above, you can optionally specify here to fall back to
   authentication with dn.
   This is useful, when users should be able to log in with their uid, but
   the ldap administrator wants to log in with his root-dn, that does not
   necessarily have the uid attribute.
   When using this feature, login_class is ignored. */
// $servers->setValue('login','fallback_dn',false);

/* Specify true If you want phpLDAPadmin to not display or permit any
   modification to the LDAP server. */
// $servers->setValue('server','read_only',false);

/* Specify false if you do not want phpLDAPadmin to draw the 'Create new' links
   in the tree viewer. */
// $servers->setValue('appearance','show_create',true);

/* Set to true if you would like to initially open the first level of each tree. */
// $servers->setValue('appearance','open_tree',false);

/* This feature allows phpLDAPadmin to automatically determine the next
   available uidNumber for a new entry. */
// $servers->setValue('auto_number','enable',true);

/* The mechanism to use when finding the next available uidNumber. Two possible
   values: 'uidpool' or 'search'.
   The 'uidpool' mechanism uses an existing uidPool entry in your LDAP server to
   blindly lookup the next available uidNumber. The 'search' mechanism searches
   for entries with a uidNumber value and finds the first available uidNumber
   (slower). */
// $servers->setValue('auto_number','mechanism','search');

/* The DN of the search base when the 'search' mechanism is used above. */
#  $servers->setValue('auto_number','search_base','ou=People,dc=example,dc=com');

/* The minimum number to use when searching for the next available number
   (only when 'search' is used for auto_number. */
// $servers->setValue('auto_number','min',array('uidNumber'=>1000,'gidNumber'=>500));

/* If you set this, then phpldapadmin will bind to LDAP with this user ID when
   searching for the uidnumber. The idea is, this user id would have full
   (readonly) access to uidnumber in your ldap directory (the logged in user
   may not), so that you can be guaranteed to get a unique uidnumber for your
   directory. */
// $servers->setValue('auto_number','dn',null);

/* The password for the dn above. */
// $servers->setValue('auto_number','pass',null);

/* Enable anonymous bind login. */
// $servers->setValue('login','anon_bind',true);

/* Use customized page with prefix when available. */
#  $servers->setValue('custom','pages_prefix','custom_');

/* If you set this, then only these DNs are allowed to log in. This array can
   contain individual users, groups or ldap search filter(s). Keep in mind that
   the user has not authenticated yet, so this will be an anonymous search to
   the LDAP server, so make your ACLs allow these searches to return results! */
#  $servers->setValue('login','allowed_dns',array(
#   'uid=stran,ou=People,dc=example,dc=com',
#   '(&(gidNumber=811)(objectClass=groupOfNames))',
#   '(|(uidNumber=200)(uidNumber=201))',
#   'cn=callcenter,ou=Group,dc=example,dc=com'));

/* Set this if you dont want this LDAP server to show in the tree */
// $servers->setValue('server','visible',true);

/* Set this if you want to hide the base DNs that dont exist instead of
   displaying the message "The base entry doesnt exist, create it?"
// $servers->setValue('server','hide_noaccess_base',false);
#  $servers->setValue('server','hide_noaccess_base',true);

/* This is the time out value in minutes for the server. After as many minutes
   of inactivity you will be automatically logged out. If not set, the default
   value will be ( session_cache_expire()-1 ) */
#  $servers->setValue('login','timeout',30);

/* Set this if you want phpldapadmin to perform rename operation on entry which
   has children. Certain servers are known to allow it, certain are not. */
// $servers->setValue('server','branch_rename',false);

/* If you set this, then phpldapadmin will show these attributes as
   internal attributes, even if they are not defined in your schema. */
// $servers->setValue('server','custom_sys_attrs',array(''));
#  $servers->setValue('server','custom_sys_attrs',array('passwordExpirationTime','passwordAllowChangeTime'));

/* If you set this, then phpldapadmin will show these attributes on
   objects, even if they are not defined in your schema. */
// $servers->setValue('server','custom_attrs',array(''));
#  $servers->setValue('server','custom_attrs',array('nsRoleDN','nsRole','nsAccountLock'));

/* These attributes will be forced to MAY attributes and become option in the
   templates. If they are not defined in the templates, then they wont appear
   as per normal template processing. You may want to do this because your LDAP
   server may automatically calculate a default value.
   In Fedora Directory Server using the DNA Plugin one could ignore uidNumber,
   gidNumber and sambaSID. */
// $servers->setValue('server','force_may',array(''));
#  $servers->setValue('server','force_may',array('uidNumber','gidNumber','sambaSID'));

/*********************************************
 * Unique attributes                         *
 *********************************************/

/* You may want phpLDAPadmin to enforce some attributes to have unique values
   (ie: not belong to other entries in your tree. This (together with
   'unique','dn' and 'unique','pass' option will not let updates to
   occur with other attributes have the same value. */
#  $servers->setValue('unique','attrs',array('mail','uid','uidNumber'));

/* If you set this, then phpldapadmin will bind to LDAP with this user ID when
   searching for attribute uniqueness. The idea is, this user id would have full
   (readonly) access to your ldap directory (the logged in user may not), so
   that you can be guaranteed to get a unique uidnumber for your directory. */
// $servers->setValue('unique','dn',null);

/* The password for the dn above. */
// $servers->setValue('unique','pass',null);
?>
