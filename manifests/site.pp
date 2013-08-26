# This is the default node that defines all the basics for each host
# in the Vagrant environment.
#
node default {

  # Set some defaults for things that we should more sure about
  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }
  File { owner => 'root', group => 'root' }

# We may want to setup stages, mostly so repos get set before other things
#  # run stages so we set up our repos first
#  stage { 'pre': before => Stage['main'] }
#  class { 'repos': stage => 'pre' }


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
  package {'httpd':
    ensure => latest
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

  # Modules for everyone
  include vim
}

# This is the node for the puppet-master
#
node 'master.vagrant' inherits default {
  package {'puppet-server':
    ensure => latest
  }
  service { 'puppetmaster':
    enable => true,
    ensure => running,
    require => Package['puppet-server']
  }

# The following lines could be uncommented to start using
# puppetdb. You must first install the puppetdb module and all of its
# dependancies. 
##  class { 'puppetdb':
##    database => 'embedded',
##  }
##  class { 'puppetdb::master::config':
##  }
}
