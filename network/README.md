## 加入已有的docker network

1. project1的网络不需变动
2. 新项目project2/compose.yml的网络配置 `external: true` ; <br> 若不知道project1的网络名，可使用docker inspect
   查看project1中已运行容器信息