# ingress
## 安装controller
```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
```
## 安装负载均衡
	Kubernetes 不为裸机集群提供网络负载均衡器的实现（LoadBalancer 类型的服务)。 Kubernetes 附带的 Network LB 的实现都是调用各种 IaaS 平台（GCP，AWS，Azure 等）的粘合代码。 如果你未在受支持的 IaaS 平台（GCP，AWS，Azure 等）上运行，则 LoadBalancers 在创建后将无限期保持 “pending” 状态。

### 使用MetalLB
1,安装[参考文档](https://makeoptim.com/service-mesh/kubeadm-kubernetes-istio-setup#metallb)

```shell
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml 
# On first install only 
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```

2,添加配置文件

```shell
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.16.50.147-172.16.50.148 #Update this with your Nodes IP range
EOF
```
