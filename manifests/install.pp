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
    name     => 'mysql-comunity.repo ',
    baseurl  => $mysql::baseurl,
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => $mysql::gpgkey,
    notify   => Exec['clean_cache'],
  }
  # Clean the yum cache
  exec { 'clean_cache':
    command     => 'yum clean metadata',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    timeout     => 0,
    refreshonly => true,
  }
  # Install all mysql packages
  package { 'mysq-community':
    ensure   => $mysql::package_ensure,
    name     => $mysql::package_name,
    provider => 'yum',
    require  => Exec['clean_cache'],
  }
}
