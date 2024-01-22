# redis cluster 
## 集群配置
```
# 修改为后台启动
daemonize no
# 修改端口号
port 6379
# 指定数据文件存储位置
dir /data/
# 开启集群模式
cluster-enabled yes
# 集群节点信息文件配置 ，默认值为nodes.conf，节点配置文件无须人为修改，它由 Redis集群在启动时创建， 并在有需要时自动进行更新。
cluster-config-file nodes.conf
# 集群节点超时间
cluster-node-timeout 15000
# 去掉bind绑定地址
# bind 127.0.0.1 -::1 #注释掉bind配置)
# 关闭保护模式
protected-mode no
# 开启aof模式持久化
appendonly yes
# 设置连接Redis需要密码123（选配）
requirepass 123456
# 设置Redis节点与节点之间访问需要密码123（选配）
masterauth 123456

```

## 加入集群
```
# --cluster create 创建集群实例列表 IP:PORT IP:PORT IP:PORT
# --cluster-replicas 复制因子1（即每个主节点需1个从节点）
./bin/redis-cli  --cluster create --cluster-replicas 1 redis-0.redis-service.test.svc.cluster.local:6379 redis-1.redis-service.test.svc.cluster.local:6379 redis-2.redis-service.test.svc.cluster.local:6379 redis-3.redis-service.test.svc.cluster.local:6379 redis-4.redis-service.test.svc.cluster.local:6379 redis-5.redis-service.test.svc.cluster.local:6379

```
注意：hostname 需要换成ip
	./bin/redis-cli  --cluster create --cluster-replicas 1 \
	 10.245.2.177:6379 \
	 10.245.1.218:6379 \
	 10.245.2.178:6379 \
	 10.245.1.219:6379 \
	 10.245.2.179:6379 \
   10.245.1.220:6379
