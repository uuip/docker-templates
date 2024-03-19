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
