13.03.2015

Yves Hwang
http://macyves.wordpress.com

jenkins-docker-2step
====================

2 step way to provision an environment wtih Jenkins, jenkins-job-builder and a Docker server running Vagrant for the OSX users.

No more embarrassing git commits when working with jenkins-job-builder!

Steps
=====
1. vagrant up

2. point your browser to http://localhost:38080 and enjoy

For jenkins-job-builder
=======================
1. vagrant up

2. vagrant ssh 

3. wget https://raw.githubusercontent.com/yveshwang/jenkins-config-example/master/yaml/autoupdate.yaml

4. jenkins-jobs --conf jenkins-job-builder-localhost.ini  test autoupdate.yaml -o output/
