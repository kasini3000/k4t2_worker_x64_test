
#https://docs.docker.com/engine/install/centos/
dnf remove docker `
	docker-client `
	docker-client-latest `
	docker-common `
	docker-latest `
	docker-latest-logrotate `
	docker-logrotate `
	docker-engine

@'
[docker-ce-stable]
name=Docker CE Stable x86_64
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/9/x86_64/stable/
enabled=1
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg
'@  |  set-content /etc/yum.repos.d/docker-ce.repo 

dnf remove docker-ce docker-ce-cli containerd.io
dnf install -y docker-ce-24.0.9-1.el9 #docker-ce-cli containerd.io
start-sleep -second 1
systemctl daemon-reload
systemctl enable docker
systemctl start docker

exit 0



