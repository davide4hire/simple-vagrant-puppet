#common

##Overview

Setup things that will be common to most all nodes.

##Module Description

This moudule is used to declare the resources that are common to all hosts. 

One of the main funcions is to setup the /etc/hosts file so it has the proper entries for all hosts in the vagrant multi-host setup. 

##Setup

###What [common] affects

* /etc/hosts - build to include all hosts in vagrant setup

###Setup Requirements 

Each host defined in the Vagrantfile should have a "host" entry here so it is included in the /etc/hosts file
	
