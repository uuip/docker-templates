wsgi_app = "project.wsgi"  # 模块里定义变量application，若是其他名称需要module:app标明
bind = "0.0.0.0:8000"
workers = 4
threads = 200
reload = False
daemon = False
max_requests = 3000
# errorlog = "logs/gun_error.log"
# capture_output = True # Redirect stdout/stderr to specified file in errorlog.

# workers: -w Default: 1
# worker_class: -k Default: 'sync'
# threads: --threads  Default: 1，只影响gthread
# Default: 'sync', 同时配置threads>1 则使用 gthread

# 使用gevent
# 1. pip install 'gunicorn[gevent]' # gunicorn帮我们执行了monkey.patch_all
# 2. 添加配置: worker_class = "gevent", 删除threads
# 3. psycopg3: pip install 'psycopg[binary]', 否则是纯python实现；不需要post_fork函数
# 4. psycopg2，需要安装psycogreen并post_fork

# from psycogreen.gevent import patch_psycopg

# def post_fork(server, worker):
#     patch_psycopg()

# # for fastapi and uvicorn; pip install uvicorn-worker
# import multiprocessing
#
# wsgi_app = "main:app"
# bind = "0.0.0.0:8080"
# workers = multiprocessing.cpu_count()
# worker_class = "uvicorn.workers.UvicornWorker"
# daemon = False
# max_requests = 3000

