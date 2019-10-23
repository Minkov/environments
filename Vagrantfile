Vagrant.configure(2) do |config|
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb, override|
    vb.name = "vagrant-mssql"
    vb.memory = "4096"
    vb.cpus = 4
    override.vm.box = "bento/ubuntu-18.04"
    override.vm.network "private_network", type: "dhcp"
    override.vm.network :forwarded_port, host: 1433, guest: 1433  # SQLServer
  end

  scripts = [ "bootstrap.sh" ]
  scripts.each { |script|
    config.vm.provision :shell, privileged: false, :path => "./" << script
  }

end