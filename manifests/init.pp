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
      $repository = 'https://yum.mariadb.org'
      $baseurl = "${repository}/${version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
      $gpgkey = "${repository}/RPM-GPG-KEY-MariaDB"
      $server_package = "MariaDB-server-${version}"
      $client_package = "MariaDB-client-${version}"
      $common_package = "MariaDB-common-${version}"
      $compat_libs_package = "MariaDB-compat-${version}"
      $service_name = 'mysql'
    }
    default: {
      $version_release = split($version, Regexp['[.]'])[0,2].join('.')
      $repository = 'http://repo.mysql.com'
      $baseurl = "${repository}/yum/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/"
      $gpgkey = "${repository}/RPM-GPG-KEY-mysql"
      $server_package = "mysql-community-server-${version}"
      $client_package = "mysql-community-client-${version}"
      $common_package = "mysql-community-common-${version}"
      $compat_libs_package = "mysql-community-libs-${version}"
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
