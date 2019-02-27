# mysql::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::install
class mysql::install {
  # install mysql repository
  yumrepo { 'mysql-comunity':
    ensure   => 'present',
    name     => 'mysql-comunity',
    baseurl  => $mysql::baseurl,
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => $mysql::gpgkey,
  }
  # default parameters
  Package {
    ensure   => $mysql::package_ensure,
    provider => 'yum',
  }
  # install packages
  package {
    $::mysql::common_package:
      require => Yumrepo['mysql-comunity'];
    $::mysql::compat_libs_package:
      require => Package[$::mysql::common_package];
    $::mysql::client_package:
      require => Package[$::mysql::compat_libs_package];
    $::mysql::server_package:
      require => Package[$::mysql::client_package];
  }
}
