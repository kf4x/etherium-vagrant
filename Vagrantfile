# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
    if Vagrant.has_plugin?("vagrant-vbguest")
        config.vbguest.auto_update = false
    end
    

    config.vm.define :vagrant do |ms_config|

        ms_config.vm.box = "ubuntu/trusty64"
        ms_config.vm.hostname = "nix"
        ms_config.vm.network :private_network, ip: "192.168.0.10"
        ms_config.vm.network :forwarded_port, guest: 80, host: 8080 # forwards localhost:8080 to port 80 on the vm
        ms_config.vm.network :forwarded_port, guest: 8000, host: 8001 # run app on 0.0.0.0:8000 and browser localhost:8001

        ms_config.vm.provider :virtualbox do |ms_vb|
            ms_vb.name = "eth_nix"
            ms_vb.customize ["modifyvm", :id, "--memory", "4096"]
            ms_vb.customize ["modifyvm", :id, "--cpus", "2"]
            ms_vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
            ms_vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            ms_vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        end

        ms_config.vm.provision :shell, :path => "scripts/setup.sh"
    end
    config.vm.synced_folder "src/", "/home/vagrant/app"
end


