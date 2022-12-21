### Docker: Utilização prática no cenário de Microsserviços

Pré-requisitos:
* Vagrant
* Virtualbox

O projeto possui:
* Um script do Vagrant - Para subir duas máquinas virtuais
* Dois Shell Scripts - Um script é para configurar as máquinas virtuais e o outro é para iniciar a aplicação em microsserviços num Docker Cluster Swarm
* Um script YAML - Onde possui as configurações para subir uma aplicação em stack num Cluster Docker Swarm
* Uma aplicação em PHP - Para exemplificar o uso de uma aplicação em microsserviços, em que registra o hostname do contêiner de onde foi acessada a aplicação.
