# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "jubatus"
  config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.5-x86_64-v20140311.box'
  config.omnibus.chef_version = :latest
  config.vm.network 'private_network', ip: '192.168.10.2', virtualbox__intehnt: true
  config.vm.network 'forwarded_port', guest: 9199, host: 9199

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./cookbooks"
    chef.add_recipe 'yum'
    chef.add_recipe 'yum-epel'
    chef.add_recipe 'jubatus'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'python'
    chef.add_recipe 'supervisor'
  end

  config.vm.provision :shell, inline: <<-SHELL
    echo '[program:jubatus]
command=/usr/bin/jubaclassifier -f /usr/share/jubatus/example/config/classifier/arow.json
autostart=true
autorestart=true' > jubatus.conf
    sudo service iptables stop
    sudo chkconfig iptables off
    sudo mv jubatus.conf /etc/supervisor.d/.
    sudo supervisorctl reread
    sudo supervisorctl reload
  SHELL
end
