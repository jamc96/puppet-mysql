# mysql
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql
class mysql(
  Optional[Pattern[/|^[.+_0-9:~-]+$/]] $version,
  Enum['present', 'absent'] $config_ensure,
  Enum['running', 'stopped' ] $service_ensure,
  String $config_file,
  Array $directories,
  String $package_name,
) {
  # global variables
  case $package_name {
    'mariadb': {
      # default variables 
      $os_name = $facts['operatingsystem'] ? {
        'RedHat' => 'rhel',
        default  => 'centos',
      }
      $use_version = $version ? {
        undef => '10.0.30',
        default => $version,
      }
      $package_ensure =  "${use_version}-1.el${::operatingsystemmajrelease}.${os_name}"
      $service_name = 'mysql'
    }
    default: {
      $use_version = $version ? {
        undef => '5.7.19',
        default => $version,
      }
      $package_ensure =  "${use_version}-1.el${::operatingsystemmajrelease}"
      $service_name = 'mysqld'
    }
  }
  # module containment
  contain ::mysql::install
  contain ::mysql::config
  contain ::mysql::service
  # module relationship
  Class['::mysql::install']
  -> Class['::mysql::config']
  ~> Class['::mysql::service']
}
