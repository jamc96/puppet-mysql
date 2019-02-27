# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::community
class mysql::community {
  # default variables
  $version_release = split($mysql::use_version, Regexp['[.]'])[0,2].join('.')
  # install mysql repository
  yumrepo { 'mysql-comunity':
    ensure   => 'present',
    name     => 'mysql-comunity',
    baseurl  => "http://repo.mysql.com/yum/mysql-${version_release}-community/el/${::operatingsystemmajrelease}/${::architecture}/",
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'http://repo.mysql.com/RPM-GPG-KEY-mysql',
  }
  # default parameters
  Package {
    ensure   => $mysql::package_ensure,
    provider => 'yum',
  }
  # install packages
  package {
    'mysql-community-common':
      require => Yumrepo['mysql-comunity'];
    'mysql-community-libs':
      require => Package['mysql-community-common'];
    'mysql-community-client':
      require => Package['mysql-community-libs'];
    'mysql-community-server':
      require => Package['mysql-community-client'];
  }
}
