# Class: common
#
# Setup the common resources for our Vagrant environment
#
# Parameters:
#
# Actions:
# - Add entries for all hosts into /etc/hosts
# - Ensure all the required base pacakges are present
# - Turn off any services that may be included in the base
#   OS that are not needed.
#
# Requires:
#
# Sample Usage:
#    This is meant to be included in site.pp with
#        include common
#
class common {

  # Setup all the entries for /etc/hosts
  host {'localhost':
    ip           => '127.0.0.1',
    host_aliases => [ 'localhost.localdomain', 'localhost4',
                      'localhost4.localdomain4' ],
  }
  host {'localhost6':
    ip           => '::1',
    host_aliases => ['localhost6.localdomain6' ],
  }
  host { 'master.vagrant':
    ip           => '192.168.33.10',
    host_aliases => [ 'master', 'puppet', 'vagrant-puppet-master',
                      'puppet-master', 'puppetca', 'ca' ],
  }
  host { 'client.vagrant':
    ip           => '192.168.33.20',
    host_aliases => [ 'client' ],
  }

  # Ensure all the required packages
  package {'perl-libwww-perl':
    ensure => installed
  }

  # Ensure services that don't need to be running are not
  service { 'iptables': ensure => stopped }
  service { 'ip6tables': ensure => stopped }

  # Make sure puppet is up-to-date and enabled and running
  package {'puppet':
    ensure => latest
  }
  service { 'puppet':
    enable => true,
    ensure => running,
  }

  # Include the modules we want for all hosts
  include vim
}
