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
  Enum['present', 'absent'] $package_ensure,
  Enum['present', 'absent'] $config_ensure,
  Enum['running', 'stopped' ] $service_ensure,
  String $config_file,
  Array $directories,
  String $package_name,
) {
  # global variables
  case $package_name {
    'mariadb': {
      $os_name = $facts['operatingsystem'] ? {
        'RedHat' => 'rhel',
        default  => 'centos',
      }
      $use_version = $version ? {
        undef => '10.0.29',
        default => $version,
      }
      $repository = 'https://yum.mariadb.org'
      $baseurl = "${repository}/${use_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
      $gpgkey = "${repository}/RPM-GPG-KEY-MariaDB"
      $server_package = "MariaDB-server-${use_version}"
      $client_package = "MariaDB-client-${use_version}"
      $common_package = "MariaDB-common-${use_version}"
      $compat_libs_package = "MariaDB-compat-${use_version}"
      $service_name = 'mysql'
    }
    default: {
      $use_version = $version ? {
        undef => '5.7.19',
        default => $version,
      }
      $version_release = split($use_version, Regexp['[.]'])[0,2].join('.')
      $repository = 'http://repo.mysql.com'
      $baseurl = "${repository}/yum/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/"
      $gpgkey = "${repository}/RPM-GPG-KEY-mysql"
      $server_package = "mysql-community-server-${use_version}"
      $client_package = "mysql-community-client-${use_version}"
      $common_package = "mysql-community-common-${use_version}"
      $compat_libs_package = "mysql-community-libs-${use_version}"
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
