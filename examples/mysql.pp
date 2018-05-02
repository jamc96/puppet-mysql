# Testing with another mysql version
#
class { '::mysql':
  version => '5.7.21',
}
