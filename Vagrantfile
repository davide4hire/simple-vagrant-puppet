# -*- mode: ruby -*-
# vi: set ft=ruby :
#
# This is a Vagrant file to create a multi-machine setup that can be
# used to test puppet modules and puppet agent/master setups
#
#
VAGRANTFILE_API_VERSION = "2"

# scriptlet to ensure the puppetlabs repo is installed so we can
# install puppet goodies.
$puppetRepo = <<SCRIPT
echo installing puppetlabs-release
if ! rpm -q --quiet puppetlabs-release; then
  rpm  --nosignature -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-11.noarch.rpm
fi
SCRIPT

# A scriptlet to make sure puppet is up-to-date.
# Run it after the puppetlabs repo is setup.
$puppetUpdate = <<SCRIPT
echo doing update/install of puppet
if rpm -q --quiet puppet; then
   yum -y update puppet
else
   yum -y install puppet
fi
SCRIPT

# A scriptlet to install the puppetlabs-apache module
$puppetlabsModules = <<SCRIPT
echo installing puppetlabs-apache
puppet module list | grep -q puppetlabs-apache || puppet module install puppetlabs-apache
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # The first section is configuration for all hosts.

    # Ensure Puppetlabs repo is available
    config.vm.provision :shell, :inline => $puppetRepo

    # Here are some virtualbox customizations.
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
      vb.customize ["modifyvm", :id, "--vram", "9"]
    end

    # We want to have the same vagrant-time puppet setup for all
    # hosts. That way, puppet provisioning is all the same
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "site.pp"
      puppet.module_path = "modules"
      puppet.options = ['--verbose' ]
    end

    # Next section is for setting up each machine.

    # puppet master machine
    config.vm.define :master do |master|
      master.vm.network :private_network, ip: "192.168.33.10"
      master.vm.hostname = "master.vagrant"
      master.vm.box = "centos-6-x86_64"
      master.vm.provider :virtualbox do |vb|
        vb.name = "master"
        #vb.gui = true
      end
      # For the puppet master we want to map/sync the vagrant
      # manifests and modules directory into the place a standard
      # puppet expects to find them.
      master.vm.synced_folder "./manifests", "/etc/puppet/manifests"
      master.vm.synced_folder "./modules", "/etc/puppet/modules"

      # Install the extra modules we need
      master.vm.provision :shell, :inline => $puppetlabsModules

      # Install an auto-sign file to make things go faster.
      master.vm.provision :shell,
                          :inline => "echo '*.vagrant' >/etc/puppet/autosign.conf"
      
    end

    # The main/default client. It is CentOS 6-x86_64-based.
    config.vm.define :client do |client|
      client.vm.network :private_network, ip: "192.168.33.20"
      client.vm.network :private_network, ip: "192.168.33.21"
      client.vm.network :private_network, ip: "192.168.33.22"
      client.vm.network :private_network, ip: "192.168.33.23"
      client.vm.hostname = "client.vagrant"
      client.vm.box = "centos-6-x86_64"
      client.vm.provider :virtualbox do |vb|
        vb.name = "client"
        #vb.gui = true
      end

      # Deploy the facts required to configure the sorry servers
      client.vm.provision :shell, :path => "set-client-facts.sh"
    end

end

##
##  # Forward a port from the guest to the host, which allows for outside
##  # computers to access the VM, whereas host only networking does not.
##  # config.vm.forward_port 80, 8080
##
##  # Share an additional folder to the guest VM. The first argument is
##  # an identifier, the second is the path on the guest to mount the
##  # folder, and the third is the path on the host to the actual folder.
##  # config.vm.share_folder "v-data", "/vagrant_data", "../data"
##
##  # Enable provisioning with Puppet stand alone.  Puppet manifests
##  # are contained in a directory path relative to this Vagrantfile.
##  # You will need to create the manifests directory and a manifest in
##  # the file centos-6.2.pp in the manifests_path directory.
##  #
##  # An example Puppet manifest to provision the message of the day:
##  #
##  # # group { "puppet":
##  # #   ensure => "present",
##  # # }
##  # #
##  # # File { owner => 0, group => 0, mode => 0644 }
##  # #
##  # # file { '/etc/motd':
##  # #   content => "Welcome to your Vagrant-built virtual machine!
##  # #               Managed by Puppet.\n"
##  # # }
##  #
##  # config.vm.provision :puppet do |puppet|
##  #   puppet.manifests_path = "manifests"
##  #   puppet.manifest_file  = "centos-6.2.pp"
##  # end
##
