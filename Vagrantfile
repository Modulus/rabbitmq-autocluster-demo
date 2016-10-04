# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define :master do |master_config|
    master_config.vm.box = "ubuntu/trusty64"
    master_config.vm.host_name = 'saltmaster.local'
    master_config.vm.network "private_network", ip: "192.168.50.20" #, :bridge => "eth1"
    master_config.vm.synced_folder "salt/", "/srv/salt"
  #  master_config.landrush.enabled = true


    master_config.vm.provision :salt do |salt|
      salt.master_config = "vagrant_config/master"
      salt.master_key = "vagrant_config/keys/master_minion.pem"
      salt.master_pub = "vagrant_config/keys/master_minion.pub"
      salt.minion_key = "vagrant_config/keys/master_minion.pem"
      salt.minion_pub = "vagrant_config/keys/master_minion.pub"
      salt.seed_master = {
                          "minion1" => "vagrant_config/keys/minion1.pub",
                          "minion2" => "vagrant_config/keys/minion2.pub",
                          "minion3" => "vagrant_config/keys/minion3.pub",
                          "master" => "vagrant_config/keys/master_minion.pub"
                         }

      salt.install_type = "stable"
      salt.install_master = true
      salt.no_minion = false
      salt.minion_config = "vagrant_config/master_minion"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion1 do |minion_config|
    minion_config.vm.box = "ubuntu/trusty64"
    minion_config.vm.host_name = 'saltminion1.local'
    minion_config.vm.network "private_network", ip: "192.168.50.21"
    #minion_config.landrush.enabled = true
    minion_config.vm.network "forwarded_port", guest: 443, host: 443, auto_correct: true
    minion_config.vm.network "forwarded_port", guest: 80 , host: 80, auto_correct: true
    minion_config.vm.network "forwarded_port", guest: 3000 , host: 3000, auto_correct: true
    minion_config.vm.network "forwarded_port", guest: 8083 , host: 8083, auto_correct: true
    minion_config.vm.network "forwarded_port", guest: 8086 , host: 8086, auto_correct: true
    #minion_config.vm.provider "virtualbox" do |v|
    #  v.memory = 1024
    #  v.cpus = 2
    #end
    minion_config.vm.provision :salt do |salt|
      salt.minion_config = "vagrant_config/minion1"
      #salt.grains_config = "vagrant_config/grains/web"
      salt.minion_key = "vagrant_config/keys/minion1.pem"
      salt.minion_pub = "vagrant_config/keys/minion1.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion2 do |minion_config|
    minion_config.vm.box = "ubuntu/trusty64"
    # The following line can be uncommented to use Centos
    # instead of Ubuntu.
    # Comment out the above line as well
    #minion_config.vm.box = "chef/centos-6.5"
    minion_config.vm.host_name = 'saltminion2.local'
    minion_config.vm.network "private_network", ip: "192.168.50.22"
    #minion_config.landrush.enabled = true


    minion_config.vm.provision :salt do |salt|
      salt.minion_config = "vagrant_config/minion2"
      #salt.grains_config = "vagrant_config/grains/haproxy"
      salt.minion_key = "vagrant_config/keys/minion2.pem"
      salt.minion_pub = "vagrant_config/keys/minion2.pub"
      salt.install_type = "stable"
      #minion_config.vm.provider "virtualbox" do |v|
      #  v.memory = 1024
      #  v.cpus = 2
      #end
      salt.verbose = true
      salt.colorize = true
      salt.bootstrap_options = "-P -c /tmp"
    end
  end

  config.vm.define :minion3 do |minion_config|
    minion_config.vm.box = "ubuntu/trusty64"
    # The following line can be uncommented to use Centos
    # instead of Ubuntu.
    # Comment out the above line as well
    #minion_config.vm.box = "chef/centos-6.5"
    minion_config.vm.host_name = 'saltminion3.local'
    minion_config.vm.network "private_network", ip: "192.168.50.23"
    #minion_config.landrush.enabled = true

    #minion_config.vm.provider "virtualbox" do |v|
    #  v.memory = 1024
    #  v.cpus = 2
    #end
    minion_config.vm.provision :salt do |salt|
      salt.minion_config = "vagrant_config/minion3"
      #salt.grains_config = "vagrant_config/grains/build"
      salt.minion_key = "vagrant_config/keys/minion3.pem"
      salt.minion_pub = "vagrant_config/keys/minion3.pub"
      salt.install_type = "stable"
      salt.verbose = true
      salt.colorize = true
      #salt.bootstrap_options = "-P -c -D /tmp"
    end
  end

end
