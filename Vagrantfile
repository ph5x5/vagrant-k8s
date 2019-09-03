# -*- mode: ruby -*-
# vi: set ft=ruby :
nodes = 2

Vagrant.configure("2") do |config|
    config.vm.define "k8s-master" do |node|
        config.vm.box = "ubuntu/bionic64"
        config.vm.network :private_network, type: "dhcp"
        config.vm.network "forwarded_port", guest: 6443, host: 6443
        node.vm.hostname = "k8s-master"
        node.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
            vb.cpus = "2"
            vb.name = "k8s-master"
        end
        node.vm.provision "shell", path: "k8s-install.sh"
        node.vm.provision "shell", path: "docker.sh"
        node.vm.provision "shell", path: "avahi.sh"
        node.vm.provision "shell", path: "k8s-master.sh"
    end
    (1..nodes).each do |i|
        config.vm.define "k8s-node-#{i}" do |node|
            node.vm.box = "ubuntu/bionic64"
            node.vm.hostname = "k8s-node-#{i}"
            config.vm.network :private_network, type: "dhcp"
            node.vm.provider "virtualbox" do |vb|
                vb.memory = "1024"
                vb.cpus = "2"
                vb.name = "k8s-node-#{i}"
            end
            node.vm.provision "shell", path: "k8s-install.sh"
            node.vm.provision "shell", path: "docker.sh"
            node.vm.provision "shell", path: "avahi.sh"
            node.vm.provision "shell", path: "k8s-node.sh"
        end
    end
end
