from flask import Flask, render_template, g, current_app
from flask_session import Session
from flask_sqlalchemy import SQLAlchemy
from redis import StrictRedis
from flask_wtf.csrf import CSRFProtect
import logging
from logging.handlers import RotatingFileHandler
from config import config
from flask_wtf.csrf import generate_csrf
from flask_ckeditor import CKEditor

from info.utils.common import do_index_class

db = SQLAlchemy()
# ckeditor = CKEditor()
redis_store = None  # type: StrictRedis


def setup_log(config_name):
    """配置日志"""

    # 设置日志的记录等级
    logging.basicConfig(level=config[config_name].LOG_LEVEL)  # 调试debug级
    # 创建日志记录器，指明日志保存的路径、每个日志文件的最大大小、保存的日志文件个数上限
    file_log_handler = RotatingFileHandler("logs/log", maxBytes=1024 * 1024 * 100, backupCount=10)
    # 创建日志记录的格式 日志等级 输入日志信息的文件名 行数 日志信息
    formatter = logging.Formatter('%(levelname)s %(filename)s:%(lineno)d %(message)s')
    # 为刚创建的日志记录器设置日志记录格式
    file_log_handler.setFormatter(formatter)
    # 为全局的日志工具对象（flask app使用的）添加日志记录器
    logging.getLogger().addHandler(file_log_handler)


def create_app(config_name):
    """通过传入不同的配置名字，初始化其对应配置的应用实例"""
    setup_log(config_name)
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    db.init_app(app)
    global redis_store
    redis_store = StrictRedis(host=config[config_name].REDIS_HOST, port=config[config_name].REDIS_PORT, decode_responses=True)
    csrf = CSRFProtect()
    Session(app)
    # ckeditor.init_app(app)

    from info.utils.common import user_login_data

    @app.errorhandler(404)
    def page_not_found(e):
        return render_template('404.html')

    # 创建钩子函数，在请求之后给response设置csrftoken
    @app.after_request
    def after_request(response):

        csrf_token = generate_csrf()
        # print(csrf_token)

        response.set_cookie('csrftoken', csrf_token)

        return response

    # 给模板添加过滤器
    app.add_template_filter(do_index_class, 'index_class')

    # 注册视图函数
    from info.modules.index import index_blu
    app.register_blueprint(index_blu)

    from info.modules.passport import passport_blu
    app.register_blueprint(passport_blu)

    from info.modules.news import news_blu
    app.register_blueprint(news_blu)

    from info.modules.admin import admin_blu
    app.register_blueprint(admin_blu)

    from info.modules.search import search_blu
    app.register_blueprint(search_blu)

    return app

