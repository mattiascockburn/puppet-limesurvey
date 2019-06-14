# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include limesurvey::config
class limesurvey::config (
){
  if $facts['selinux'] and $limesurvey::manage_selinux {
    file{"${limesurvey::archive_dest}/upload":
      seltype => 'httpd_sys_rw_content_t',
    }
    file{"${limesurvey::archive_dest}/tmp":
      seltype => 'httpd_sys_rw_content_t',
    }
      # Needed for LDAP Sync
      selboolean{'httpd_can_connect_ldap':
        value      => 'on',
        persistent => true,
      }
      selboolean{'httpd_setrlimit':
        value      => 'on',
        persistent => true,
      }
      selboolean{'httpd_unified':
        value      => 'on',
        persistent => true,
      }
  }
  if $limesurvey::manage_database {
    mysql::db { $limesurvey::db_name:
      user            => $limesurvey::db_user,
      password        => $limesurvey::db_password,
      host            => $limesurvey::db_host,
      grant           => ['ALL'],
    }
  }
}
