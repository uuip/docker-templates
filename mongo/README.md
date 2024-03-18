## 注意事项

1. 副本集mongo1 rs.initiate命令中`参数：节点`应当使用映射到主机的IP与端口
2. 生成key

    ```shell
    openssl rand -base64 768 > conf/mongo-replication.key
    chmod 600 conf/mongo-replication.key
    chown 999 conf/mongo-replication.key  # Linux主机时
    ```

3. 修改compose.yml MONGO_INITDB_ROOT_PASSWORD
4. 如果mongo提示vm.max_map_count问题，在主机中配置vm.max_map_count=1677720
5. Standalone 对外映射端口；Standalone_internal 不对外映射端口，仅限 docker compose 项目内。