#!/bin/bash -eux

apt-get -yq install openjdk-8-jdk openjdk-8-jre;
#update-alternatives --config java
#update-alternatives --config javac
if [[ -d /usr/lib/jvm/java-8-openjdk-amd64 ]]; then ln -s /usr/lib/jvm/java-8-openjdk-amd64 /usr/lib/jvm/java-8-openjdk; fi;
POLICY_DIR="/vagrant/UnlimitedJCEPolicyJDK8";
if [ ! -f /vagrant/jce_policy-8.zip ]; then ${ARIA2C_DOWNLOAD} --header="Cookie: oraclelicense=accept-securebackup-cookie" -d /vagrant -o jce_policy-8.zip http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip; fi;
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
unzip /vagrant/jce_policy-8.zip;
mkdir -p /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security;
cp -f ${POLICY_DIR}/US_export_policy.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/US_export_policy.jar;
cp -f ${POLICY_DIR}/local_policy.jar /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/local_policy.jar;
rm -rf ${POLICY_DIR};

wget https://github.com/sormuras/bach/raw/master/install-jdk.sh;
#wget https://github.com/sormuras/bach/raw/support-older-jdks/install-jdk.sh
bash install-jdk.sh -F 11 --target $HOME/openjdk11 --workspace $HOME/.cache/install-jdk;
if [[ -d /home/vagrant/openjdk11 ]]; then ln -s /home/vagrant/openjdk11 /usr/lib/jvm/java-11-openjdk-amd64; fi;
if [[ -d /home/vagrant/openjdk11 ]]; then ln -s /home/vagrant/openjdk11 /usr/lib/jvm/java-11-openjdk; fi;

echo -e '\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /home/vagrant/.profile
echo -e '\nexport PATH=${JAVA_HOME}/bin:$PATH' >> /home/vagrant/.profile
