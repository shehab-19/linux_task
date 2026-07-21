# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Ubuntu 22.04 Jammy
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_version = "20241002.0.0"


  # -------------------------
  # DNS Server - BIND9
  # -------------------------
  config.vm.define "dns1" do |dns|
    dns.vm.hostname = "dns1"
    dns.vm.network "private_network", ip: "192.168.56.10"

    dns.vm.provider "virtualbox" do |vb|
      vb.name = "dns1"
      vb.memory = 512
      vb.cpus = 1
      vb.gui = false
    end

    dns.vm.provision "shell",
      path: "provision/dns.sh",
      args: ["test.com"]
  end

  # -------------------------
  # NGINX Server 1 - MASTER
  # -------------------------
  config.vm.define "web1" do |web|
    web.vm.hostname = "web1"
    web.vm.network "private_network", ip: "192.168.56.11"

    web.vm.provider "virtualbox" do |vb|
      vb.name = "web1"
      vb.memory = 1024
      vb.cpus = 1
      vb.gui = false

      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"] # keep all traffic for vip 
    end

    web.vm.provision "shell",
      path: "provision/web.sh",
      args: ["web1", "MASTER"]
  end

  # -------------------------
  # NGINX Server 2 - BACKUP
  # -------------------------
  config.vm.define "web2" do |web|
    web.vm.hostname = "web2"
    web.vm.network "private_network", ip: "192.168.56.12"

    web.vm.provider "virtualbox" do |vb|
      vb.name = "web2"
      vb.memory = 1024
      vb.cpus = 1
      vb.gui = false

      vb.customize ["modifyvm", :id, "--nicpromisc2", "allow-all"] # keep all traffic for vip 
    end

    web.vm.provision "shell",
      path: "provision/web.sh",
      args: ["web2", "BACKUP"]
  end




end