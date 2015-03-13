# -*- mode: ruby -*-
# vi: set ft=ruby :

# Yves Hwang 11.03.2015
# Test Jenkins and Jenkins job builder setup

$script= <<SCRIPT
echo doing some apt-get install stuff
apt-get update
apt-get install git -y
apt-get install python-pip -y
apt-get install devscripts -y
apt-get install debhelper -y
apt-get install checkinstall -y
apt-get install curl -y
apt-get install rst2pdf -y
echo .......
echo intalling jenkins
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | tee -a /etc/apt/sources.list
apt-get update
apt-get install jenkins -y
service jenkins restart
echo ......
echo installing jenkins-job-builder
git clone https://github.com/openstack-infra/jenkins-job-builder
cd jenkins-job-builder
pip install -r requirements.txt && python setup.py install
cd ..
echo ......
echo setup jenkins plugin
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin gradle -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin clone-workspace-scm -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin buildresult-trigger -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin violations -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin analysis-core -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin git -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin junit -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin findbugs -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin sonar -deploy
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin hipchat -deploy
echo ......
echo setup jenkins user
cd /vagrant
curl -X POST -d @localhost_test_cred http://localhost:8080/credential-store/domain/_/createCredentials -v
service jenkins restart
echo ......
echo install some aws tools
pip install awsebcli
pip install awscli
echo .....
SCRIPT

# script from https://macyves.wordpress.com/2014/05/31/docker-in-osx-via-boot2docker-or-vagrant-getting-over-the-hump/
$dockersetup= <<SCRIPT
wget -q -O - https://get.docker.io/gpg | apt-key add -
echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
apt-get update -qq 
apt-get install -q -y --force-yes lxc-docker
usermod -a -G docker vagrant
sed -e 's/DOCKER_OPTS=/DOCKER_OPTS=\"-H 0.0.0.0:4243\"/g' /etc/init/docker.conf > /vagrant/docker.conf.sed
cp /vagrant/docker.conf.sed /etc/init/docker.conf
rm -f /vagrant/docker.conf.sed
service docker restart
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, :inline => $script
  config.vm.provision :shell, :inline => $dockersetup
  config.vm.network "forwarded_port", guest: 8080, host: 38080
  config.vm.network "forwarded_port", guest: 4243, host: 4243
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--name", "cloud_infra", "--memory", "2048"]
  end
end
