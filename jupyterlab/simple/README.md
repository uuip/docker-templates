## 修改密码

1. 使用`python -m jupyter_server.auth password`生成密码
2. 修改 jupyter_lab_config.py 中认证部分：
```jupyterpython
# c.NotebookApp.token = ''
c.ServerApp.password = "password"
c.ServerApp.password_required = True
```
