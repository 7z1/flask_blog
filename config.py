import os

import redis
import logging

BASE_DIR = os.path.dirname(os.path.abspath(__file__))


class Config(object):
    # 默认日志等级
    LOG_LEVEL = logging.DEBUG
    SECRET_KEY = "EjpNVSNQTyGi1VvWECj9TvC/+kq3oujee2kTfQUs8yCM6xX9Yjq52v54g+HVoknA"
    # 数据库的配置信息
    SQLALCHEMY_DATABASE_URI = "mysql://root:demonisme@127.0.0.1:3306/blog_site?charset=utf8mb4"
    SQLALCHEMY_COMMIT_ON_TEARDOWN = True
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    REDIS_HOST = '127.0.0.1'
    REDIS_PORT = 6379
    # flask_session的配置信息
    SESSION_TYPE = "redis"  # 指定 session 保存到 redis 中
    SESSION_USE_SIGNER = True  # 让 cookie 中的 session_id 被加密签名处理
    SESSION_REDIS = redis.StrictRedis(host=REDIS_HOST, port=REDIS_PORT)  # 使用 redis 的实例
    PERMANENT_SESSION_LIFETIME = 86400  # session 的有效期，单位是秒


class DevelopementConfig(Config):
    """开发模式下的配置"""
    DEBUG = True


class ProductionConfig(Config):
    """生产模式下的配置"""
    LOG_LEVEL = logging.ERROR
    DEBUG = False
    pass


config = {
    "development": DevelopementConfig,
    "production": ProductionConfig
}
