# Class: redirect-servers
#
# This class defines all the resources to implement a redirect server.
#
# Parameters:
#
# Actions:
# - realizes a "redirect server"
#
# Requires:
# - base-apache, apache

# Sample Usage:
#
class redirect-servers {
  # Bring in the base setup for httpd/apache
  include base-apache

  # Make sure teh apache stuff is "before" this class
  Class['base-apache'] ~> Class['redirect-servers']

  $redirectBase = '/var/www'

  # Here we check for a fact that indicates which redirect server
  # should be instantiated. The value of the fact is the IP address of
  # the instance.
  if getvar('::homeaway_redirect') {
    redirect-servers::homeaway-redirect { 'homeaway-redirect':
      ip      => $::homeaway_redirect,
      baseDir => $redirectBase,
    }
  }
}
