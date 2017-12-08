# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/xenial64"

    config.vm.box_check_update = false
    config.vbguest.auto_update = false

    config.vm.network :private_network, ip: "192.168.33.10"

    config.vm.synced_folder "./config/nginx", "/etc/nginx/sites-available",
        id: "nginx",
        :nfs => true,
        :mount_options => ['nolock,vers=3,udp,noatime']

    config.vm.synced_folder "./html", "/var/www/html",
        id: "core",
        :nfs => true,
        :mount_options => ['nolock,vers=3,udp,noatime']

    config.vm.provider :virtualbox do |vb|
        host = RbConfig::CONFIG['host_os']

        # Give VM 1/4 system memory
        if host =~ /darwin/
            # sysctl returns Bytes and we need to convert to MB
            cpus = `sysctl -n hw.ncpu`.to_i
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4

        elsif host =~ /linux/
            # meminfo shows KB and we need to convert to MB
            cpus = `nproc`.to_i
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4

        elsif host =~ /mswin|mingw|cygwin/
            # Windows code via https://github.com/rdsubhas/vagrant-faster
            cpus = `wmic cpu Get NumberOfCores`.split[1].to_i
            mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024 / 1024 / 4

        # Windows...
        else
            cpus = 4
            mem = 4096
        end

        vb.customize ["modifyvm", :id, "--cpus", cpus]
        vb.customize ["modifyvm", :id, "--memory", mem]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
        vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
    end

    config.vm.provision :shell, :path => "scripts/build.sh"
    config.vm.provision :shell, :inline => "service nginx reload", run: "always"
end
