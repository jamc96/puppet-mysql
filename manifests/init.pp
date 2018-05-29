# mysql
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql
class mysql(
  Optional[Pattern[/|^[.+_0-9:~-]+$/]] $version = undef,
  Pattern[/present|absent/] $package_ensure     = 'present',
  Pattern[/present|absent/] $config_ensure      = 'present',
  Pattern[/running|stopped/] $service_ensure    = 'running',
  String $config_file                           = '/etc/my.cnf',
  String $service_name                          = 'mysqld',
) {

  # global variables
  $use_version = $version ? {
    undef => '5.7.19',
    default => $version,
  }
  $version_release = split($use_version, Regexp['[.]'])[0,2].join('.')
  $repo_url = 'http://repo.mysql.com'
  $baseurl = "${repo_url}/yum/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/"
  $gpgkey = "${repo_url}/RPM-GPG-KEY-mysql"
  $server_package_name = "mysql-community-server-${use_version}"
  $client_package_name = "mysql-community-client-${use_version}"
  $common_package_name = "mysql-community-common-${use_version}"
  $libs_package_name = "mysql-community-libs-${use_version}"

  # module containment
  contain ::mysql::install
  contain ::mysql::config
  contain ::mysql::service
  # module relationship
  Class['::mysql::install']
  -> Class['::mysql::config']
  ~> Class['::mysql::service']
}
