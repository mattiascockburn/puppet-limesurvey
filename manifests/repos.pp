# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include limesurvey::repos
class limesurvey::repos (
  Boolean $enable_epel,
  Boolean $enable_scl,
  Array[String] $scl_collections,
) {
    if $facts['os']['family'] == 'RedHat' {
      if $enable_epel {
        contain epel
      }
      if $enable_scl {
        contain scl
        $scl_collections.each |$scl_collection| {
          ::scl::collection{$scl_collection:
            enable => true,
          }
        }
      }
    }
    else {
      fail('Only RHEL-derivatives are supported')
    }
}
