## git repo 地址格式

```text
git@github.com:YOUR-USERNAME/YOUR-REPOSITORY.git
ssh://git@ssh.github.com:443/YOUR-USERNAME/YOUR-REPOSITORY.git
```

- 后者用于不能正常访问github的22端口时，参见[在 HTTPS 端口使用 SSH](https://docs.github.com/zh/authentication/troubleshooting-ssh/using-ssh-over-the-https-port)

- 在compose.yaml的context中，只能使用第一种格式。

***

## 使用 ssh agent

```yaml
    ssh:
      - default
```

### 检查状态

```shell
$ ssh-add -l
2048 d7:8e:3d:03:9c:4f:f8:9d:04:0f:11:c5:24:e1:2f:3a rsa w/o comment (RSA)
```

如果不是类似上述输出，则执行：

```shell
eval `ssh-agent`
ssh-add
```

***

### 指定 ssh key

除了使用agent，还可以直接指定key<br>

```yaml
    ssh:
      - default=/root/.ssh/id_rsa
```