wsgi_app = "project.wsgi"  # 模块里定义变量application，若是其他名称需要module:app标明
bind = "0.0.0.0:8000"
# worker_class: -k Default: 'sync', 同时配置threads>1 则使用 gthread
workers = 4  # -w Default: 1
threads = 200  # --threads  Default: 1，只影响gthread
reload = False
daemon = False
max_requests = 3000  # maximum number of requests before restarting a worker
accesslog = "-"  # --access-logfile
errorlog = "-"  # --error-logfile
timeout = 300
# pidfile = "app.pid"
# capture_output = True # Redirect stdout/stderr to specified file in errorlog.

# ======================================================= #
# 使用gevent
# 1. pip install 'gunicorn[gevent]' # gunicorn 帮我们执行了monkey.patch_all
# 2. 添加配置: worker_class = "gevent", 删除threads
# 3. psycopg3: pip install 'psycopg[binary]', 否则是纯python实现；不需要post_fork函数
# 4. psycopg2，需要安装psycogreen并post_fork

# from psycogreen.gevent import patch_psycopg

# def post_fork(server, worker):
#     patch_psycopg()

# ======================================================= #
# fastapi and uvicorn
# 1. 多数情况直接使用 uvicorn 即可
# 2. pip install uvicorn-worker
# 3. worker_class = "uvicorn.workers.UvicornWorker"
