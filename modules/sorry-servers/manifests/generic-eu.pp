# Class: sorry-servers::generic-eu
#
# This class instantiates the sorry-generic-eu vhost
#
# Parameters:
#   ip      = The IP address for this apache vhost instance
#   baseDir = The base/root directory for the apache vhost
#
# Actions:
# - Creates an instance of the sorry-generic-eu server
#
# Requires:
#
# Sample Usage:
#
define sorry-servers::generic-eu ($ip, $baseDir) {
  
  # Ensure the base directory is available
  $rootDir = "$baseDir/sorry-generic-eu"
  file { "$rootDir":
    ensure => 'directory'
  }

  # Use a template to define the string that is the HTML contents of
  # the response.
  $htmlContents = template('sorry-servers/simple-sorry.html')
  $fewoContents = template('sorry-servers/fewo.html')
  $abritelContents = template('sorry-servers/abritel.html')

  # Define the basic/default virtual host for the sorry servers
  sorry-servers::vhost {'sorry-generic-eu.vagrant':
    ip                 => $ip,
    baseDir            => $rootDir,
    aliases            => ['sorry-generic-eu', 'homeaway-eu.vagrant', 'homeaway-eu'],
    contentType        => 'text/html',
    contentStr         => $htmlContents,
    defaultSorry       => true,
  }

  # Define the basic/default virtual host for the sorry servers
  sorry-servers::vhost {'sorry-fewo.vagrant':
    ip                 => $ip,
    baseDir            => $rootDir,
    aliases            => ['sorry-fewo', 'fewo.vagrant', 'fewo'],
    contentType        => 'text/html',
    contentStr         => $fewoContents,
  }

  # Define the basic/default virtual host for the sorry servers
  sorry-servers::vhost {'sorry-abritel.vagrant':
    ip                 => $ip,
    baseDir            => $rootDir,
    aliases            => ['sorry-abritel', 'abritel.vagrant', 'abritel'],
    contentType        => 'text/html',
    contentStr         => $abritelContents,
  }

  # The custom_config can be 'content' (snippet) or 'source' (a file)
  apache::custom_config { 'myconf':
    priority => false,
    content => '# Testing for custom config - DavidE',
  }
}
