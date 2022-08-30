!#/bin/bash

sudo yum install -y ca-certificates >> /dev/log1
echo ca-certificates updated

 wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate >> /dev/log1
   echo jenkins downloaded


 rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key >> /dev/log1
   echo key downloaded

  yum install epel-release >> /dev/log1
   echo epel installed

  yum install java-11-openjdk-devel -y  >> /dev/log1
   echo java installed


  yum install jenkins -y >> /dev/log1
   echo jenkins installed


  systemctl enable jenkins
  echo jenkins enabled

  systemctl start jenkins

    echo jenkins started
     cd
    cd var/lib/jenkins/secrets

    cat initialAdminPassword



