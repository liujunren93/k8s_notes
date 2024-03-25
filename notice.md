## 1, failed: open /run/flannel/subnet.env: no such file or directory
### master:
``` bash
cat > /run/flannel/subnet.env <<EOF
FLANNEL_NETWORK=10.245.0.0/16
FLANNEL_SUBNET=10.245.0.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true
EOF
```
### node1:
``` bash
cat > /run/flannel/subnet.env <<EOF
FLANNEL_NETWORK=10.245.0.0/16
FLANNEL_SUBNET=10.245.1.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true
EOF
```
### node2:
``` bash
cat > /run/flannel/subnet.env <<EOF
FLANNEL_NETWORK=10.245.0.0/16
FLANNEL_SUBNET=10.245.2.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true
EOF
```
