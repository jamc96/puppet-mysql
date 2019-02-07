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
  Enumer['running', 'stopped' ] $service_ensure,
  String $config_file,
  String $service_name,
  Array $directories,
) {
  # global variables
  $version_release = split($version, Regexp['[.]'])[0,2].join('.')
  $repo_url = 'http://repo.mysql.com'
  $baseurl = "${repo_url}/yum/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/"
  $gpgkey = "${repo_url}/RPM-GPG-KEY-mysql"
  $server_package_name = "mysql-community-server-${version}"
  $client_package_name = "mysql-community-client-${version}"
  $common_package_name = "mysql-community-common-${version}"
  $libs_package_name = "mysql-community-libs-${version}"

  # module containment
  contain ::mysql::install
  contain ::mysql::config
  contain ::mysql::service
  # module relationship
  Class['::mysql::install']
  -> Class['::mysql::config']
  ~> Class['::mysql::service']
}
