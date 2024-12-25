# install docker
sudo dnf update -y
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io -y

# set max_user_namespaces
sudo echo user.max_user_namespaces=28633 >> /etc/sysctl.conf
sudo sysctl --system

# install iptables
sudo dnf install iptables -y

# install rootless
sudo sh -eux <<EOF
  modprobe ip_tables
EOF

cd /usr/bin
dockerd-rootless-setuptool.sh install

# start docker
systemctl --user start docker

# start with os
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

