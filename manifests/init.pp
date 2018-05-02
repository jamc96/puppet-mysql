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
  Pattern[/present|absent/] $package_ensure  = 'present',
  Pattern[/present|absent/] $config_ensure   = 'present',
  Pattern[/running|stopped/] $service_ensure = 'running',
) {

  # global variables
  $use_version = $version ? {
    undef => '5.7.19',
    default => $version,
  }
  $version_release = $use_version.match(/^(\d+)\.(\d+)/)
  $yumrepo_url = 'http://repo.mysql.com/yum'
  $baseurl = "${yumrepo_url}/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/"
  $gpgkey = "${yumrepo_url}/RPM-GPG-KEY-mysql"
  $package_name = "mysql-community-server-${use_version}"

  # module containment
  contain ::mysql::install

  class { '::mariadb::install': }
}
