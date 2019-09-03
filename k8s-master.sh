#!/bin/bash
kubeadm config images pull
kubeadm init --apiserver-advertise-address=$(hostname -I | cut -d' ' -f2) --pod-network-cidr=172.28.128.0/24

sudo --user=vagrant mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown $(id -u vagrant):$(id -g vagrant) /home/vagrant/.kube/config

cp -i /etc/kubernetes/admin.conf /vagrant/config

export KUBECONFIG=/etc/kubernetes/admin.conf
curl -o kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sed -i.bak 's|"/opt/bin/flanneld",|"/opt/bin/flanneld", "--iface=enp0s8",|' kube-flannel.yml
kubectl create -f kube-flannel.yml
rm -f kube-flannel*

kubeadm token create --print-join-command > /etc/kubeadm_join_cmd.sh
chmod +x /etc/kubeadm_join_cmd.sh

sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart

kubectl apply -f /vagrant/ingress/ingress.yaml

iptables -t nat -A PREROUTING -p tcp --dport 6443 -j REDIRECT --to-port 6443
