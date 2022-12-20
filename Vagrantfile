Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.define "node1" do |node1|
    node1.vm.network "public_network", ip: "192.168.31.11"
    node1.vm.network "public_network", ip: "172.16.0.201"
    node1.vm.hostname = "node1"
    node1.vm.synced_folder "arquivosCluster/", "/home/vagrant/arquivosCluster/", disabled: false
#    node1.vm.provision "file", source: "arquivosCluster/toshiro-stack.yml", destination: "/home/vagrant/toshiro-stack.yml"
#    node1.vm.provision "file", source: "arquivosCluster/criarAppToshiro.sh", destination: "/home/vagrant/criarAppToshiro.sh"
#    node1.vm.synced_folder "arquivosCluster/app/", "/var/lib/docker/volumes/toshiro_dados-app/_data/", disabled: false
    node1.vm.provision "shell", path: "configuraNodes.sh"
#    node1.vm.provision "shell", inline: "bash /home/vagrant/arquivosCluster/criarAppToshiro.sh"
    node1.vm.synced_folder ".", "/home/vagrant", disabled: true
    node1.vm.provider "virtualbox" do |v|
      v.name = "node1"
      v.memory = 2048
      v.cpus = 1
      v.linked_clone = true
    end
  end

  config.vm.define "node2" do |node2|
    node2.vm.network "public_network", ip: "192.168.31.12"
    node2.vm.network "public_network", ip: "172.16.0.202"
    node2.vm.hostname = "node2"
    node2.vm.synced_folder "arquivosCluster/", "/home/vagrant/arquivosCluster/", disabled: false
#    node2.vm.synced_folder "arquivosCluster/app/", "/var/lib/docker/volumes/toshiro_dados-app/_data/", disabled: false
    node2.vm.provision "shell", path: "configuraNodes.sh"
    node2.vm.synced_folder ".", "/home/vagrant", disabled: true
    node2.vm.provider "virtualbox" do |v|
      v.name = "node2"
      v.memory = 2048
      v.cpus = 1
      v.linked_clone = true
    end
  end

end
