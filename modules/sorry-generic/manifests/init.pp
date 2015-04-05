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
class sorry-generic {
  
  # Bring in the base setup for httpd/apache
  include base-apache
  
  # Ensure the base directory is available
  file { '/var/www/sorry-generic':
    ensure => 'directory'
  }

  # Define the basic/default virtual host for the sorry servers
  apache::vhost { 'sorry-generic':
    access_log_format  => 'ha_logs',
    access_log_file    => 'sorry-generic.log',
    docroot            => '/var/www/sorry-generic/html',
  }

  # The custom_config can be 'content' (snippet) or 'source' (a file)
  apache::custom_config { 'myconf':
    priority => false,
    content => '# Testing for custom config - DavidE',
  }


}
