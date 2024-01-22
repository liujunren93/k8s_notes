# service
- ### 概念：
   Kubernetes 中 Service 是 将运行在一个或一组 Pod 上的网络应用程序公开为网络服务的方法。
   
- ### yaml
	```yaml
    apiVersion: v1
    kind: Service
    metadata:
        name: my-service
    spec:
        selector:
            app.kubernetes.io/name: MyApp
        ports:
           - protocol: TCP
              port: 80
              type: [ClusterIP(default),NodePort,LoadBalancer,ExternalName]
              targetPort: [端口，pod.name] // 绑定到pod
							nodePort: 30000   # NodePort 下使用 暴露给外部的 NodePort
	     
	```
		type: 
			ClusterIP:默认值，内部访问

# statefulset
# deployment