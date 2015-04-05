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

}

node 'client.vagrant' {
  include common
}

# This is the node for the puppet-master
#
node 'master.vagrant' inherits default {

  # Bring in the common stuff
  include common
  
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
