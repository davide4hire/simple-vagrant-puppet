# CLass: vim::params
#
# This class manages Vim parameters
#
# Paramters:
# - The $vim_package is the name of the package that installs the editor on the relevant distribution
#
# Actions:
#
# Requires:
#
# Sample Usage:
class vim::params {

  case $operatingsystem {
    'centos', 'redhat', 'fedora': {
       $vim_package = [ 'vim-enhanced' ]
    }
    default: {
       $vim_package = 'vim'
    }
  }
}
