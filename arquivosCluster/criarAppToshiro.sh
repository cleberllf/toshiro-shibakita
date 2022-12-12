#!/bin/bash
#docker network create rede-toshiro
#docker volume create dados-bd
#docker volume create dados-app
#docker container run --name toshiro-bd --hostname mysql --network rede-toshiro --network-alias mysql -e MYSQL_ROOT_PASSWORD=Senha123 -e MYSQL_DATABASE=bd_toshiro -d -p 3306:3306 --volume=dados-bd:/var/lib/mysql mysql:5.7
#docker container run --name toshiro-bd --hostname mysql -d -p 3306:3306 --network rede-toshiro --volume=dados-bd/bd/:/var/lib/mysql mysql:5.7
#docker container run --name toshiro-app --hostname app -d -p 80:80 --network rede-toshiro --network-alias app --volume=dados-app:/app/ webdevops/php-apache:alpine-php7
sudo docker stack up toshiro -c toshiro-stack.yml
