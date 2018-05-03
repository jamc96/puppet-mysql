# mysql::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::service
class mysql::service {
  service { $::mysql::service_name:
    ensure     => $::mysql::service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
