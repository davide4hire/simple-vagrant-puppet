simple-vagrant-puppet
=====================

This is a [Vagrant][http://vagrantup.com/] setup for creating a multi-machine environment for
exploring, learning or developing puppet modules using a very basic
puppet master and client configuration.


What?
=====

The idea is to create a very basic puppet master/agent configuration
to allow you to work on puppet modules. It is so basic that the puppet
master and agent use default vaules for everything.  So one machine is
reachable by the hostname 'puppet'

The basic setup will allow you to write and test your own modules or
to install and test modules from the Puppet Forge or from github.com
or from anywhere else. You can work on the modules without worrying
about how they might interact with your production puppet environment.

How?
====

The Vagrantfile configures two ViritulBox machines. One will be a
puppet master and one will be a basic puppet client. They are setup
using the most basic puppet defaults.

Sorry Servers
=============

One setup is for creating and testing basic 'sorry servers'. What is a
'sorry server'? It is an Apache virtual host that responds with a 503
status code and a simple page for every request, except for an "alive"
check page. The idea is to configure a sorry server as a backup
virtual server in a load balancer.

On the branch `sorry-server` is all the configuration to create some
simple sorry servers.  It can be tested with commands like this:

    GET -eS -H 'Host: fewo' http://192.168.33.20

The above command should generate output that has the words *Fewo Sorry Page*

	GET -eS -H 'Host: abritel' http://192.168.33.20

The above command should generate output that has the words *French Sorry Page*

    GET -eS -H 'Host: fewo' http://192.168.33.21

The above commmand will produce an empty document.
