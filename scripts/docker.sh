#!/bin/bash -eux

ARIA2C_DOWNLOAD="aria2c --file-allocation=none -c -x 10 -s 10 -m 0 --console-log-level=notice --log-level=notice --summary-interval=0"

pwd
ls -ahl
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key add docker_ubuntu_gpg
#add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge"
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) nightly"
#sed -i "s#https://download.docker.com/linux/ubuntu#https://${IMAGE_ARG_APT_MIRROR:-mirrors.tuna.tsinghua.edu.cn}/docker-ce/linux/ubuntu#g" /etc/apt/sources.list
echo '>>>>>>>>>> /etc/apt/sources.list >>>>>>>>>>'
cat /etc/apt/sources.list
echo '<<<<<<<<<< /etc/apt/sources.list <<<<<<<<<<'
apt-get -y update
apt-get -y remove docker docker-engine docker.io
apt-cache madison docker-ce
apt-get -yq install docker-ce
service docker start
if [ ! -f /home/vagrant/.docker/config.json ]; then mkdir -p /home/vagrant/.docker; touch /home/vagrant/.docker/config.json; echo '{}' > /home/vagrant/.docker/config.json; fi
chown root:vagrant /var/run/docker.sock
chmod 660 /var/run/docker.sock
usermod -a -G docker vagrant || echo "useradd: user 'vagrant' already exists"

${ARIA2C_DOWNLOAD} -d /usr/local/bin -o docker-compose https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m`
chown root:vagrant /usr/local/bin/docker-compose
chmod 775 /usr/local/bin/docker-compose
