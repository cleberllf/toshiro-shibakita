Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.define "node1" do |node1|
    node1.vm.network "public_network", ip: "192.168.31.11"
    node1.vm.hostname = "node1"
    node1.vm.provision "shell", inline: "timedatectl set-timezone America/Bahia"
    node1.vm.provision "shell", inline: "curl -fsSL https://get.docker.com | sh -"
    node1.vm.provision "shell", inline: "grep -iq \"alias docker='sudo docker'\" .bashrc || echo -e \"alias apt=\'sudo apt\'\nalias apt-get=\'sudo apt-get\'\nalias docker=\'sudo docker\'\nalias docker-compose=\'sudo docker-compose\' \" >> /home/vagrant/.bashrc"
    node1.vm.provision "shell", inline: "apt-get install -y -qq docker-compose mysql-client"
#    node1.vm.provision "shell", inline: "apt-get install -y -qq nfs-server"
#    node1.vm.provision "shell", inline: "echo '/var/lib/docker/volumes/ 192.168.31.12(rw,sync,subtree_check)' > /etc/exports && exportfs -ar"
#    node1.vm.provision "shell", inline: "chmod 707 /var/lib/docker/volumes/"
    node1.vm.provision "shell", inline: "grep -iq '192.168.31.12 node2' /etc/hosts || echo '192.168.31.12 node2' >> /etc/hosts"
    node1.vm.synced_folder "arquivosCluster/", "/home/vagrant/arquivosCluster/", disabled: false
    node1.vm.provision "shell", inline: "docker swarm join-token worker | grep -i 'join --token' > /home/vagrant/arquivosCluster/swarm-join || docker swarm init --advertise-addr 192.168.31.11 >> /home/vagrant/arquivosCluster/swarm-join"
    node1.vm.provision "shell", inline: "docker pull mysql:5.7 && docker pull webdevops/php-apache:alpine-php7"
    node1.vm.provision "shell", inline: "docker build -t proxy-reverso:1.0 /home/vagrant/arquivosCluster/proxyReverso/"
#    node1.vm.provision "file", source: "arquivosCluster/banco.sql", destination: "/home/vagrant/banco.sql"
#    node1.vm.provision "file", source: "arquivosCluster/app/index.php", destination: "/home/vagrant/app/index.php"
#    node1.vm.provision "file", source: "arquivosCluster/toshiro-stack.yml", destination: "/home/vagrant/toshiro-stack.yml"
#    node1.vm.provision "file", source: "arquivosCluster/criarAppToshiro.sh", destination: "/home/vagrant/criarAppToshiro.sh"
#    node1.vm.provision "shell", inline: "docker stack up toshiro -c /home/vagrant/arquivosCluster/toshiro-stack.yml"
#    node1.vm.provision "shell", inline: "cp /home/vagrant/arquivosCluster/app/*.* /var/lib/docker/volumes/toshiro_dados-app/_data/"
    node1.vm.synced_folder "arquivosCluster/app/", "/var/lib/docker/volumes/toshiro_dados-app/_data/", disabled: false
    node1.vm.synced_folder "arquivosCluster/bancoDeDados/", "/var/lib/docker/volumes/toshiro_dados-bd/_data/", disabled: false
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
    node2.vm.hostname = "node2"
    node2.vm.provision "shell", inline: "timedatectl set-timezone America/Bahia"
    node2.vm.provision "shell", inline: "curl -fsSL https://get.docker.com | sh -"
    node2.vm.provision "shell", inline: "grep -iq \"alias docker='sudo docker'\" .bashrc || echo -e \"alias apt=\'sudo apt\'\nalias apt-get=\'sudo apt-get\'\nalias docker=\'sudo docker\'\nalias docker-compose=\'sudo docker-compose\' \" >> /home/vagrant/.bashrc"
#    node2.vm.provision "shell", inline: "apt-get install -y nfs-common autofs"
    node2.vm.provision "shell", inline: "grep -iq '192.168.31.11 node1' /etc/hosts || echo '192.168.31.11 node1' >> /etc/hosts"
    node2.vm.synced_folder "arquivosCluster/", "/home/vagrant/arquivosCluster/", disabled: false
#    node2.vm.provision "shell", inline: "mount -t nfs -o v3 node1:/var/lib/docker/volumes/ /var/lib/docker/volumes/"
#    node2.vm.provision "shell", inline: "echo 'node1:/var/lib/docker/volumes/ /volumes/ nfs defaults 0 0' >> /etc/fstab"
#    node2.vm.provision "shell", inline: "echo '/- /etc/auto.mount' >> /etc/auto.master && echo '/var/lib/docker/volumes/ -fstype=nfs,rw node1:/var/lib/docker/volumes/' >> /etc/auto.mount && systemctl restart autofs"
    node2.vm.provision "shell", inline: "grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - 2> /home/vagrant/arquivosCluster/erroSwarm || { grep -iq 'This node is already part of a swarm' /home/vagrant/arquivosCluster/erroSwarm && rm -f /home/vagrant/arquivosCluster/erroSwarm && docker swarm leave --force && grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - ; }"
    node2.vm.provision "shell", inline: "[ -e /home/vagrant/arquivosCluster/swarm-join ] && { rm -f /home/vagrant/arquivosCluster/swarm-join && echo 'Arquivo com o token do Cluster Swarm removido com sucesso.'; } || { echo 'Erro: Arquivo com o token do Cluster Swarm não existe.'; }"
    node2.vm.provision "shell", inline: "docker pull mysql:5.7 && docker pull webdevops/php-apache:alpine-php7"
    node2.vm.provision "shell", inline: "docker build -t proxy-reverso:1.0 /home/vagrant/arquivosCluster/proxyReverso/"
    node2.vm.synced_folder "arquivosCluster/app/", "/var/lib/docker/volumes/toshiro_dados-app/_data/", disabled: false
    node2.vm.synced_folder "arquivosCluster/bancoDeDados/", "/var/lib/docker/volumes/toshiro_dados-bd/_data/", disabled: false
    node2.vm.synced_folder ".", "/home/vagrant", disabled: true
    node2.vm.provider "virtualbox" do |v|
      v.name = "node2"
      v.memory = 2048
      v.cpus = 1
      v.linked_clone = true
    end
  end  
end
