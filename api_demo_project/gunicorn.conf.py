wsgi_app = "project.wsgi"
bind = "0.0.0.0:8000"
workers = 4
threads = 100
reload = False
daemon = False
keepalive = 8

# 使用gevent
# 1. pip install 'gunicorn[gevent]'
# 2. psycopg3: pip install 'psycopg[binary]', 否则是纯python实现；不需要post_fork函数
# 3. psycopg2，需要安装psycogreen并post_fork
# 4. 添加配置: worker_class = "gevent"

# def post_fork(server, worker):
#     from psycogreen.gevent import patch_psycopg
#
#     patch_psycopg()
