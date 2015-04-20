# Class: sorry-servers::blank
#
# This class instantiates a sorry server that returns a blank/empty page.
#
# Parameters:
#   ip      = The IP address for this apache vhost instance
#   baseDir = The base/root directory for the apache vhost. It must
#             exist or be managed elsewhere. 
#
# Actions:
# - Creates an instance of the sorry-blank server
#
# Requires:
# - apache-base, sorry-servers::vhost
#
# Sample Usage:
#
define sorry-servers::blank ($ip, $baseDir) {
  
  # Ensure the base directory is available
  $rootDir = "$baseDir/sorry-blank"
  file { "$rootDir":
    ensure => 'directory'
  }

  # Use a template to define the string that is the HTML contents of
  # the response.
  $htmlContents = template('sorry-servers/blank-sorry.txt')

  # Define the basic/default virtual host for the sorry servers
  sorry-servers::vhost {'sorry-blank.vagrant':
    ip                 => $ip,
    baseDir            => $rootDir,
    aliases            => ['sorry-blank'],
    contentType        => 'text/plain',
    contentStr         => $htmlContents,
    defaultSorry       => true,
  }
}
