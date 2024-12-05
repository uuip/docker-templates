## 注意事项

1. 不同部署方式

   | 文件夹 | 节点 | 端口 |
   |----------|--------|---------|
   | Standalone | 单节点 | 通过 ports 配置是否对外映射端口 | 
   | ReplicaSet_1node | 单节点副本集 | 对外映射端口 | 
   | ReplicaSet_1node_internal | 单节点副本集 | 不对外映射端口 |
   | ReplicaSet_3nodes | 3节点副本集 | 对外映射端口 | 

2. 生成key

    ```shell
    openssl rand -base64 768 > conf/mongo-replication.key
    chmod 600 conf/mongo-replication.key
    chown 999 conf/mongo-replication.key  # Linux主机时
    ```

3. 修改密码 MONGO_INITDB_ROOT_PASSWORD
4. 如果mongo提示vm.max_map_count问题，在主机中配置vm.max_map_count=1677720
5. 如何连接副本集

```yaml
    extra_hosts:
      - "host.docker.internal=host-gateway"
    healthcheck:
      test: test $$(mongosh -u $${MONGO_INITDB_ROOT_USERNAME} -p $${MONGO_INITDB_ROOT_PASSWORD} --quiet --eval 'try {rs.status().ok} catch (err) {rs.initiate({_id:"rs0",members:[{_id:0,host:"host.docker.internal:27017"}]}).ok}') -eq 1
```

当前主机的局域网IP不固定，故此使用`host.docker.internal`; 若有固定IP或者域名，会方便很多。

`mongodb://1.2.3.4/`

单节点的实例可以通过上述URL直接访问；而如果是副本集，mongo客户端会通过这个URL获取所有节点，然后访问节点的`host/name`属性；在初始化时使用的是`host.docker.internal`，客户端不能解析。有几种方法：

- 客户端主机添加hosts解析`host.docker.internal`
- 初始化时改用固定IP或者域名
- 连接时使用`mongodb://1.2.3.4/?=directConnection=true`

