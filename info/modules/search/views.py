import time
from datetime import datetime, timedelta

from info import constants, db
from info.models import User, News, Category, AdminUser, NewsAction, Gbook, Link
from info.utils.common import user_login_data, get_ua
from info.utils.response_code import RET
from . import search_blu
from flask import render_template, current_app, session, request, jsonify, g


@search_blu.route('/search', methods=['get', 'post'])
def search():
    # 1. 获取参数
    keywords = request.args.get('keywords', None)

    filters = [News.status == 0]

    if keywords:
        # 如果有关键字，将关键字假如过滤
        filters.append(News.title.contains(keywords))

    news_list = []
    current_page = 1
    total_page = 1

    # 查询statu状态为0的文章
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(1, constants.ADMIN_NEWS_PAGE_MAX_COUNT, False)
        news_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)

    news_dict = []

    for news in news_list:
        news_dict.append(news.to_dict())

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_index_dict())

    # 获取新闻分类数据
    categories = Category.query.all()
    # 定义列表保存分类数据
    categories_dicts = []

    for category in categories:
        # 拼接内容
        categories_dicts.append(category.to_dict())

    data = {
        'new_li': news_dict,
        'current_page': current_page,
        'total_page': total_page,
        'admin_dict': admin_dict[0],
        'categories_dicts': categories_dicts
    }

    return render_template('search.html', data=data)



