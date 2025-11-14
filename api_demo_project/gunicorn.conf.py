# 这4个放到命令行方便
bind = "0.0.0.0:8000"  # -b --bind
workers = 4  # -w --workers Default: 1
worker_class = "gthread"  # -k --worker-class Default: 'sync', 同时配置threads>1 则使用 gthread
threads = 200  # --threads  Default: 1，只影响gthread

wsgi_app = "project.wsgi"  # 模块里定义变量application，若是其他名称需要module:app标明
accesslog = "-"  # --access-logfile Default: None
errorlog = "-"  # --error-logfile Default: -
timeout = 300  # -t --timeout
pidfile = "app.pid"  # -p --pid Default: None

# max_requests = 0  # --max-requests Default: 0 disabled, maximum number of requests before restarting a worker
# reload = False # --reload Default: False
# preload_app = False # --preload Default: False
# daemon = False # -D --daemon Default: False
# loglevel = "info" # --log-level   Default: info

# ===============fastapi and UvicornWorker==================== #
# 1. 多数情况直接使用 uvicorn 即可
# 2. pip install uvicorn-worker
# 3. worker_class = "uvicorn.workers.UvicornWorker"

# ================gevent======================================= #
from gunicorn.arbiter import Arbiter
from gunicorn.workers.ggevent import GeventWorker
from gevent import events as gevent_events


def post_fork(server: Arbiter, worker: GeventWorker):
    # print(isinstance(worker, GeventWorker))
    # print(gevent.monkey.is_anything_patched())
    pass


def post_patch(event):
    # 使用gevent
    # 1. pip install 'gunicorn[gevent]' # gunicorn 帮我们执行了monkey.patch_all
    # 2. 添加配置: worker_class = "gevent", 删除threads
    # 3. psycopg3: pip install 'psycopg[binary]'；不需要post_fork函数
    # 4. psycopg2，需要安装psycogreen并post_fork
    if not isinstance(event, gevent_events.GeventDidPatchBuiltinModulesEvent):
        return
    import psycogreen.gevent as pscycogreen_gevent  # type: ignore

    pscycogreen_gevent.patch_psycopg()


gevent_events.subscribers.append(post_patch)