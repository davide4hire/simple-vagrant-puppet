# Class: sorry-servers::vhost
#
# This class declares the apache vhost for the sorry server.
#
# Parameters:
#    name:        the server name to use for the vhost
#    baseDir:     the base directory for the vhost, contains all files
#                 related to this vhost
#    contentType: the HTTP response content-type for vhost
#    contentFile: the file that contains the content to be served on
#                 every request for this vhost. It is just the content, no response
#                 headers or anything else.  Content must match
#                 specified contentType.
#
# Actions:
# - Installs the vim package
# - Sets up roots .exrc file so we have sane tab stops everywhere
#
# Requires:
#
# Sample Usage:
#
define sorry-servers::vhost (
  $ip,
  $port = 80,
  $baseDir,
  $aliases = [],
  $contentType,
  $contentStr,
  $defaultSorry = false) {

  # define the doc root using baseDir and the name of the vserver
  $rootDir = "$baseDir/$name"
  file { "$rootDir":
    ensure => directory,
  }
  
  # Define the alive check for the sorry server
  $aliveFile = "$rootDir/alive.txt"
  file { "$aliveFile" :
    content => template('sorry-servers/alive.txt.erb'),
    mode    => "a=rx",
    ensure  => present,
  }

  # Define the main script file.
  $scriptFile = "$rootDir/503.sh"
  file { "$scriptFile":
    content => template('sorry-servers/503.sh.erb'),
    mode    => "a=rx",
    ensure  => present,
  }

  # Define the basic/default virtual host for the sorry servers
  apache::vhost { "$name":
    ip                 => $ip,
    port               => $port,
    add_listen         => false,
    default_vhost      => str2bool("$defaultSorry"),
    serveraliases      => $aliases,
    access_log_format  => 'sorry',
    access_log_file    => 'sorry-servers.log',
    docroot            => "$rootDir/html",
    aliases            => [ { scriptalias => '/alive.txt',
                              path        => "$aliveFile/"},
                            { scriptalias => '/', path => "$scriptFile/" }
                          ],
  }
}

