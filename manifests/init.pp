# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include limesurvey
class limesurvey(
  Boolean $manage_repos,
  Boolean $manage_database,
  Boolean $manage_packages,
  Boolean $manage_php,
  Boolean $manage_selinux,
  Boolean $use_ldap,
  Array[String] $packages,
  String $php_version,
  Hash $php_settings,
  String $owner,
  String $group,
  String $basedir,
  String $sha1sum,
  String $archive_name,
  String $archive_dest,
  String $url,
  String $db_user,
  String $db_password,
  String $db_host,
  String $db_name,
) {
  if $manage_repos {
    contain limesurvey::repos
  }
  contain limesurvey::install
  contain limesurvey::config
}
