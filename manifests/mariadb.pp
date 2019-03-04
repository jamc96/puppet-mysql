# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::mariadb
class mysql::mariadb inherits mysql {
  # install mysql repository
  yumrepo { 'mariadb':
    ensure   => 'present',
    name     => 'mariadb',
    baseurl  => "https://yum.mariadb.org/${mysql::use_version}/${mysql::os_name}/${::operatingsystemmajrelease}/${::architecture}/",
    descr    => 'MariaDB respository',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
  }
  # default parameters
  Package {
    ensure   => $mysql::package_ensure,
    provider => 'yum',
  }
  # install packages
  package {
    'MariaDB-common':
      require => Yumrepo['mariadb'];
    'MariaDB-compat':
      require => Package['MariaDB-common'];
    'MariaDB-client':
      require => Package['MariaDB-compat'];
    'MariaDB-server':
      require => Package['MariaDB-client'];
  }
}
