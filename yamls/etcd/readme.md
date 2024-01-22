## 创建集群
```bash
etcd --name=$(hostname) \
      --data-dir=/data/etcd/$(hostname) \
      --listen-client-urls=http://0.0.0.0:2379 \
      --advertise-client-urls=http://$(hostname).etcd-service.test.svc.cluster.local:2379 \
      --listen-peer-urls=http://0.0.0.0:2380 \
      --initial-advertise-peer-urls=http://$(hostname).etcd-service.test.svc.cluster.local:2380 \
      --initial-cluster=etcd-0=http://etcd-0.etcd-service.test.svc.cluster.local:2380,etcd-1=http://etcd-1.etcd-service.test.svc.cluster.local:2380,etcd-2=http://etcd-2.etcd-service.test.svc.cluster.local:2380 \
      --initial-cluster-token=etcd-cluster-1 \
      --initial-cluster-state=new \
      --log-level=info \
      --logger=zap \
      --log-outputs=stderr
```

	--name：etcd集群中的节点名，这里可以随意，可区分且不重复就行 
	--listen-peer-urls：监听的用于节点之间通信的url，可监听多个，集群内部将通过这些url进行数据交互(如选举，数据同步等)http:0.0.0.0:2380
	--initial-advertise-peer-urls：建议用于节点之间通信的url，节点间将以该值进行通信 http://host:2380。
	--listen-client-urls：监听的用于客户端通信的url，同样可以监听多个。http://0.0.0.0:2379
	--advertise-client-urls：建议使用的客户端通信 url，该值用于 etcd 代理或 etcd 成员与 etcd 节点通信。 http://host:2379
	--initial-cluster-token： etcd-cluster-1，节点的 token 值，设置该值后集群将生成唯一 id，并为每个节点也生成唯一 id，当使用相同配置文件再启动一个集群时，只要该 token 值不一样，etcd 集群就不会相互影响。
	--initial-cluster：也就是集群中所有的 initial-advertise-peer-urls 的合集。
	--initial-cluster-state：new，新建集群的标志

``` bash
./etcdctl --endpoints=http://etcd-0.etcd-service.test.svc.cluster.local:2379,http://etcd-1.etcd-service.test.svc.cluster.local:2379,http://etcd-2.etcd-service.test.svc.cluster.local:2379 endpoint status -w table
```