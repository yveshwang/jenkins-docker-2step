# -*- mode: ruby -*-
# vi: set ft=ruby :

# Yves Hwang 27.04.2018
# Test Jenkins, and Jenkinsfile and Jenkins job builder setup via Docker
#   - Jenkins is running on docker, see README.md
#   - jenkins-job-builder is install on the vm, so simulate a working environment inside the VM so you don't have to pollute your own lappy

$script= <<SCRIPT
echo doing some apt-get install stuff
apt-get update
apt-get install -y python-pip
sudo pip install --upgrade pip
sudo pip install jenkins-job-builder
SCRIPT

# script from https://macyves.wordpress.com/2014/05/31/docker-in-osx-via-boot2docker-or-vagrant-getting-over-the-hump/
$dockersetup= <<SCRIPT
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
groupadd docker
usermod -aG docker ubuntu
docker run hello-world
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, :inline => $script
  config.vm.provision :shell, :inline => $dockersetup
  config.vm.network "forwarded_port", guest: 8080, host: 38080
  config.vm.network "forwarded_port", guest: 4243, host: 4243
  config.vm.provider :virtualbox do |vb|
    vb.memory = 2048
    vb.cpus = 1
  end
end
