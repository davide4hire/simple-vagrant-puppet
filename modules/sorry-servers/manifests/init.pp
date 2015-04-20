# Class: sorry-servers
#
# This class causes the proper sorry servers to be instantiated on a
# host. Generally, which vhosts to define should be determined by the
# node classifier.
#
# Parameters:
#
# Actions:
# - realizes a "sorry server"
#
# Requires:
# - base-apache, apache

# Sample Usage:
#
class sorry-servers {

  # Bring in the base setup for httpd/apache
  include base-apache

  # make sure the apache stuff is before this
  Class['base-apache'] ~> Class['sorry-servers']

  $sorryBaseDir = '/var/www'
  
  # Here we check for fact for various sorry servers. The fact name
  # will be the name of the sorry server and the fact value will be
  # the ip address for that instance.
  if getvar('::sorry_generic_eu') {
    sorry-servers::generic-eu { 'sorry-generic-eu':
      ip      => $::sorry_generic_eu,
      baseDir => $sorryBaseDir,
    }
  }

  if getvar('::sorry_blank') {
    sorry-servers::blank { 'sorry-blank':
      ip      => $::sorry_blank,
      baseDir => $sorryBaseDir,
    }
  }
}
