# mysql::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::config
class mysql::config
{
  File{
    owner                   => 'mysql',
    group                   => 'mysql',
    selinux_ignore_defaults => true,
  }
  file {
    $mysql::config_file:
      ensure => $mysql::config_ensure,
      path   => $mysql::config_file,
      mode   => '0774';
    '/etc/my.cnf.d':
      ensure  => 'directory',
      mode    => '0755',
      require => File[$mysql::config_file],
  }
}
