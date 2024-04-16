## 修改密码

1. 使用`python -m jupyter_server.auth password`生成密码<br>
2. 修改 jupyterlab/with_django/.jupyter/jupyter_lab_config.py 中 c.ServerApp.password

## 使用:

1. 登录地址 http://127.0.0.1:7000
2. 从`Django Shell-Plus`图标启动 notebook
3. Django 模型通过 django-extensions 自动加载
4. 在项目根目录应当具有写权限

## 其他配置说明

- 添加 `django_extensions` 到 `INSTALLED_APPS`
- 生成配置文件：
  `jupyter lab --generate-config`
  `ipython profile create`
- 修改密码 jupyter_lab_config.py
  `from jupyter_server.auth import passwd; passwd()`
  or
  `python -m jupyter_server.auth password`

## 配置 auto-import

- shell_plus 自动导入模型, 要自动导入其他包:
    - 方法 1. `vim $IPYTHONDIR/profile_default/ipython_config.py`

  ```jupyterpython
  c.InteractiveShellApp.exec_lines = [
    'import pandas as pd', 'import jedi', 'jedi.settings.case_insensitive_completion = True'
  ]
  ```

    - 方法 2. (current) 添加启动文件到 `$IPYTHONDIR/profile_default/startup/`

    - 方法 3. Django's settings file ( support: `import` or `from ... import ...` ) :

      ```python
      SHELL_PLUS_POST_IMPORTS = ['import pandas as pd']
      ```