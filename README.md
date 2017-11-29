27.11.2017

jenkins-docker-2step
====================

2 steps to provision an environment with Jenkins, `jenkins-job-builder` and `docker` env running cleanly inside a `vagrant` box.

No more embarrassing git commits when working with Jenkinsfile or jenkins-job-builder!

Steps
=====
```
vagrant up
vagrant ssh -c "docker run -u root --rm -d -p 8080:8080 -v /vagrant/jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkinsci/blueocean"
```
For jenkins-job-builder
=======================
```
# check your job with jenkins-job-builder
jenkins-job-builder --conf jenkins-job-builder-localhost.ini test seed/autoupdate.yaml
```

For fiddling with jenkins
=========================

```
# get the jar file first for the cli to work
wget http://localhost:38080/jnlpJars/jenkins-cli.jar

# login and check stuff
java -jar jenkins-cli.jar -s http://localhost:38080 who-am-i --username admin --password "$(cat jenkins-data/secrets/initialAdminPassword)"

# add a job
# Use jenkins-job-builder or JobDSL and click through the pain. I prefer the former.

# to lint your Jenkinsfile
java -jar jenkins-cli.jar -s http://localhost:38080 declarative-linter < Jenkinsfile
```

Some pitfalls
=============
* the user in vagrant by default is `ubuntu` and it is added to the `docker` usergroup. However, this may not be the case for the the blueocean docker container. So ensure you add `-u root` to any docker commands whilst within the jenkins container itself.

* turn off security to safe some keystrokes. naturally this is NOT production ready but really more of an exploration. Do this under the "Configure Global Security" section. For example, toggle "Enable CLI over remoting" and "Anyone can do anything" during this exploration.

Author
======
Yves Hwang
http://macyves.wordpress.com
