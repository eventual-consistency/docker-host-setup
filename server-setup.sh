#!/bin/bash

# Install the Docker Engine
apt-get install curl -y
curl https://get.docker.com/ | sh

# Set storage driver
tee /etc/docker/daemon.json <<EOF
{
        "storage-driver": "overlay2"
}
EOF

# Install UFW
apt-get install ufw -y
systemctl enable ufw
systemctl start ufw

# Start Docker
systemctl enable docker
systemctl start docker

# Run Rancher
docker run -d -v /data/rancher/mysql:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server
ufw allow 8080
