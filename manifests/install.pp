# mysql::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::install
class mysql::install {
  # Install mysql repository
  yumrepo { 'mysql-comunity':
    ensure   => 'present',
    name     => 'mysql-comunity',
    baseurl  => $mysql::baseurl,
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => $mysql::gpgkey,
  }
  File {
    ensure   => $mysql::package_ensure,
    provider => 'yum',
  }
  # Install all mysql packages
  package {
    'mysql-community-common':
      require => Yumrepo['mysql-comunity'];
    'mysql-community-libs':
      require => Package[$::mysql::common_package_name];
    'mysql-community-client':
      require => Package[$::mysql::libs_package_name];
    'mysql-community-server':
      require => Package[$::mysql::client_package_name];
  }
}
