# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include limesurvey::install
class limesurvey::install (
) {
  if $limesurvey::manage_php {
    class { '::php::globals':
      php_version => $limesurvey::php_version,
      rhscl_mode  => 'rhscl',
    }
    ->
    class { '::php':
      manage_repos => false,
      settings     => $limesurvey::php_settings,
      fpm_user     => $limesurvey::owner,
      fpm_group    => $limesurvey::group,
    }
  }

  if $limesurvey::manage_packages {
    ensure_packages($limesurvey::packages)
  }

  exec{'limesurvey_create_basedir':
    command => "mkdir -p ${limesurvey::basedir}",
    path    => ['/bin','/usr/bin'],
    creates => $limesurvey::basedir,
  } ->
  file { $limesurvey::archive_dest:
    ensure => directory,
    owner  => $limesurvey::owner,
    group  => $limesurvey::group,
    mode   => '0755',
  }

  file { "${limesurvey::basedir}/current":
  ensure => 'link',
  target => "$limesurvey::archive_dest"
  }

  archive { $limesurvey::archive_name:
    path            => "/var/tmp/${limesurvey::archive_name}",
    source          => $limesurvey::url,
    checksum        => $limesurvey::sha1sum,
    checksum_type   => 'sha256',
    extract_command => 'tar xfj %s --strip-components=1',
    extract         => true,
    extract_path    => $limesurvey::archive_dest,
    creates         => "${limesurvey::archive_dest}/README.md",
    cleanup         => true,
    user            => $limesurvey::owner,
    group           => $limesurvey::group,
    require         => File[$limesurvey::archive_dest],
    }
}
