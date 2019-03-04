# mysql::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::config
class mysql::config inherits mysql {
  # default parameters
  File {
    owner                   => 'mysql',
    group                   => 'mysql',
    selinux_ignore_defaults => true,
  }
  # create main file
  file { $mysql::config_file:
    ensure => $mysql::config_ensure,
    path   => $mysql::config_file,
    mode   => '0774';
  }
  # create aditional directories
  $mysql::directories.each | $name | {
    file { $name:
      ensure => directory,
    }
  }
}
