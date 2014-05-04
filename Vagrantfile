# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "jubatus"
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.omnibus.chef_version = :latest
  config.vm.network 'private_network', ip: '192.168.10.2', virtualbox__intehnt: true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./cookbooks"
    chef.add_recipe 'apt'
    chef.add_recipe 'jubatus'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'python'
    # chef.add_recipe 'supervisor'
    chef.json = {
      apt: {"compiletime" => true},
      python: {
        version: '3.3'
      }
    }
  end
end
