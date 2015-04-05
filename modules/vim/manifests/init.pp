# Class: vim
#
# This class installs the vim editor
#
# Parameters:
#
# Actions:
# - Installs the vim package
# - Sets up roots .exrc file so we have sane tab stops everywhere
#
# Requires:
#
# Sample Usage:
#
class vim {

  include vim::params

  package { 'vim':
    name   => $vim::params::vim_package,
    ensure => installed,
  }

  file { '/root/.exrc':
    ensure => file,
    source => 'puppet:///modules/vim/root_exrc',
    owner  => 'root',
    group  => 'root'
  }
}
