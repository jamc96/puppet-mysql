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
    $::mysql::common_package_name:
      require => Yumrepo['mysql-comunity'];
    $::mysql::libs_package_name:
      require => Package[$::mysql::common_package_name];
    $::mysql::client_package_name:
      require => Package[$::mysql::libs_package_name];
    $::mysql::server_package_name:
      require => Package[$::mysql::client_package_name];
  }
}
