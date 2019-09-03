#!/bin/bash
#!/bin/bash
apt-get install -y sshpass
sshpass -p "vagrant" scp -o StrictHostKeyChecking=no vagrant@k8s-master.local:/etc/kubeadm_join_cmd.sh .

sh ./kubeadm_join_cmd.sh
