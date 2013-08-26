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

