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
1. Start up your Vagrant box
    vagrant up
2. Login to the Vagrant box
    vagrant ssh 

3. Fetch the autoupdater script
    https://raw.githubusercontent.com/yveshwang/jenkins-config-example/master/yaml/autoupdate.yaml

4. Test the Jenkins job generation before sending it to Jenkins
    jenkins-jobs --conf jenkins-job-builder-localhost.ini  test autoupdate.yaml -o output/

5. Ready to go? Send it to your Jenkins
    jenkins-jobs --conf jenkins-job-builder-localhost.ini update autoupdate.yaml
