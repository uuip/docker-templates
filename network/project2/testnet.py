import time

from loguru import logger
from redis import Redis

r: Redis = Redis.from_url("redis://redis/0")


def main():
    for x in range(600):
        v = r.incrby("test_key")
        logger.info(v)
        time.sleep(1)


if __name__ == "__main__":
    main()
