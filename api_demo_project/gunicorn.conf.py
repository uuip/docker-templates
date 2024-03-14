# 1. 安装依赖 gunicorn, gevent
# 2. pg驱动：psycopg3: pip install 'psycopg[binary]', 否则是纯python实现；不需要post_fork
# 3. 若使用psycopg2，需要安装psycogreen并post_fork
# 4. 容器方式启动，配置 daemon = False

wsgi_app = "project.wsgi"
bind = "0.0.0.0:8000"
workers = 4
worker_class = "gevent"
reload = False
daemon = False
keepalive = 8
errorlog = "logs/gun_error.log"
# Redirect stdout/stderr to specified file in errorlog.
capture_output = True


# def post_fork(server, worker):
#     from psycogreen.gevent import patch_psycopg
#
#     patch_psycopg()
