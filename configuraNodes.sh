#!/bin/bash
ipNode1="192.168.31.11"
ipNode2="192.168.31.12"

case "$HOSTNAME" in
    node1)
        timedatectl set-timezone America/Bahia
        curl -fsSL https://get.docker.com | sh -
        grep -iq "alias docker='sudo docker'" .bashrc || echo -e "alias apt='sudo apt'\nalias apt-get='sudo apt-get'\nalias docker='sudo docker'\nalias docker-compose='sudo docker-compose'" >> /home/vagrant/.bashrc
        apt-get install -y -qq docker-compose mysql-client
#        apt-get install -y -qq nfs-server
#        echo '/var/lib/docker/volumes/ '$ipNode2'(rw,sync,subtree_check)' > /etc/exports && exportfs -ar
#        chmod 707 /var/lib/docker/volumes/
        grep -iq $ipNode2' node2' /etc/hosts || echo $ipNode2' node2' >> /etc/hosts
        docker swarm join-token worker | grep -i 'join --token' > /home/vagrant/arquivosCluster/swarm-join || docker swarm init --advertise-addr $ipNode1 >> /home/vagrant/arquivosCluster/swarm-join
        docker pull mysql:5.7 && docker pull webdevops/php-apache:alpine-php7 && docker pull nginx
    ;;

    node2)
        timedatectl set-timezone America/Bahia
        curl -fsSL https://get.docker.com | sh -
        grep -iq "alias docker='sudo docker'" .bashrc || echo -e "alias apt='sudo apt'\nalias apt-get='sudo apt-get'\nalias docker='sudo docker'\nalias docker-compose='sudo docker-compose'" >> /home/vagrant/.bashrc
        grep -iq $ipNode1' node2' /etc/hosts || echo $ipNode1' node2' >> /etc/hosts
#        apt-get install -y nfs-common autofs
#        mount -t nfs -o v3 node1:/var/lib/docker/volumes/ /var/lib/docker/volumes/
#        echo 'node1:/var/lib/docker/volumes/ /volumes/ nfs defaults 0 0' >> /etc/fstab
#        echo '/- /etc/auto.mount' >> /etc/auto.master && echo '/var/lib/docker/volumes/ -fstype=nfs,rw node1:/var/lib/docker/volumes/' >> /etc/auto.mount && systemctl restart autofs
#        grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - 2> /home/vagrant/arquivosCluster/erroSwarm || { grep -iq 'This node is already part of a swarm' /home/vagrant/arquivosCluster/erroSwarm && rm -f /home/vagrant/arquivosCluster/erroSwarm && docker swarm leave --force && grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - ; }
        if [ -e /home/vagrant/arquivosCluster/swarm-join ]; then
	        grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - 2> /home/vagrant/arquivosCluster/erroSwarm
        else
	        echo 'ERRO: Arquivo com o token do cluster do Docker Swarm não existe.' && echo 'ERRO: Arquivo com o token do cluster do Docker Swarm não existe.' >> /home/vagrant/arquivosCluster/erroSwarm
        fi
        if [ -e /home/vagrant/arquivosCluster/erroSwarm ]; then
	        grep -iq 'This node is already part of a swarm' /home/vagrant/arquivosCluster/erroSwarm && rm -f /home/vagrant/arquivosCluster/erroSwarm && docker swarm leave --force && grep -i 'join --token' /home/vagrant/arquivosCluster/swarm-join | sh - || cat /home/vagrant/arquivosCluster/erroSwarm
        fi
        if [ -e /home/vagrant/arquivosCluster/swarm-join ]; then
	        rm -f /home/vagrant/arquivosCluster/swarm-join && echo 'Arquivo com o token do Cluster Swarm removido com sucesso.'
        else
	        echo 'ERRO: Arquivo com o token do cluster do Docker Swarm não existe.'
        fi
        if [ -e /home/vagrant/arquivosCluster/erroSwarm ]; then
	        cat /home/vagrant/arquivosCluster/erroSwarm && rm -f /home/vagrant/arquivosCluster/erroSwarm
        else
	        echo 'Sem erro ao adicionar ao cluster do Docker Swarm'
        fi
        docker pull mysql:5.7 && docker pull webdevops/php-apache:alpine-php7 && docker pull nginx
    ;;

    *)
        echo "EXCEÇÃO";
    ;;
esac