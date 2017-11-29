# -*- mode: ruby -*-
# vi: set ft=ruby :

# Yves Hwang 11.03.2017
# Test Jenkins, and Jenkinsfile and Jenkins job builder setup via Docker

$script= <<SCRIPT
echo doing some apt-get install stuff
apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    python-pip \
    python-dev \
    build-essential
pip install --upgrade pip
pip install --upgrade virtualenv
pip install --upgrade setuptools
pip install jenkins-job-builder==2.0.0.0b2
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
