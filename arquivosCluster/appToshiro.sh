#!/bin/bash
case "$1" in
    start)
        if [ $(whoami) == root ]; then
	        docker stack up toshiro -c toshiro-stack.yml
        else
	        sudo docker stack up toshiro -c toshiro-stack.yml
        fi
    ;;
    stop)
        if [ $(whoami) == root ]; then
	        docker stack rm toshiro
        else
	        sudo docker stack rm toshiro
        fi
    ;;
    *)
        echo -e "\nFavor utilizar os parâmetros abaixo:\n\n  start - Inicia os serviços da aplicação\n  stop  - Para e remove os serviços da aplicação\n";
    ;;
esac
