#!/bin/bash
# 切换阿里源
apt-get update && apt-get install -y apt-transport-https ca-certificates curl
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

# 转发 IPv4 并让 iptables 看到桥接流量 

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
echo '1'>/proc/sys/net/ipv4/ip_forward

# 设置所需的 sysctl 参数，参数在重新启动后保持不变
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# 应用 sysctl 参数而不重新启动
sudo sysctl --system



# todo 修改key
# apt-key list
# apt-key export BE1229CF|sudo gpg --dearmour -o /etc/apt/keyrings/k8s.gpg
# deb [arch=amd64 signed-by=/etc/apt/keyrings/k8s.gpg] https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main

apt-get update
apt-get install -y kubelet=1.26.1-00  kubeadm=1.26.1-00 kubectl=1.26.1-00
apt-mark hold kubelet kubeadm kubectl

for i in `kubeadm config images list`; do
  imageName=${i#registry.k8s.io/}
  echo $imageName
  docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
  docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName registry.k8s.io/$imageName
  docker rmi registry.aliyuncs.com/google_containers/$imageName
done;

kubeadm init \
  --kubernetes-version 1.26.1 \
  --apiserver-advertise-address=0.0.0.0 \
  --service-cidr=10.96.0.0/16 \
  --pod-network-cidr=10.245.0.0/16 \
  --image-repository registry.aliyuncs.com/google_containers  \


# 安装网络插件


# 修改容器加速

[plugins."io.containerd.grpc.v1.cri".registry.mirrors."your-mirror-address"]
  endpoint = ["https://5sae6nlo.mirror.aliyuncs.com"]

