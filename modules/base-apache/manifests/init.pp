# Class: base-apache
#
# This class sets up the base configuration for the apache
# web server on a host.  It should allow other modules to set virtual
# hosts.
#
# Parameters:
#
# Actions:
# - includes the 'apache' class. This should setup the base
#   http config for the host.  
#
# Requires:
#
# Sample Usage:
#
class base-apache {
  class { 'apache':
    # Allow us to see logs without sudo
    logroot_mode => '0755',
    # Make Apache tell less about itself
    server_tokens => 'ProductOnly',
    log_formats   => {
      ha_logs  => '%v %h %l %u %t \"%r\" %>s %b',
      redirect => '%{NSCLIENTIP}i %h %{Host}i %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"',
      sorry    => '%{Host}i %v %u %t \"%r\" %>s %b %T %D',
    }
  }
}
