import time
from datetime import datetime, timedelta

from info import constants, db
from info.models import User, News, Category, AdminUser, NewsAction, Gbook, Link
from info.utils.common import user_login_data, get_ua
from info.utils.response_code import RET
from . import index_blu
from flask import render_template, current_app, session, request, jsonify, g


@index_blu.route('/time_news_list')
def time_news_list():
    """
    :return: 
    """
    # 1. 获取参数
    args_dict = request.args
    cid = args_dict.get("cid", '1')
    page = args_dict.get("page", '1')
    per_page = args_dict.get("per_page", constants.HOME_PAGE_MAX_NEWS)
    # 校验参数
    try:
        cid = int(cid)
        page = int(page)
        per_page = int(per_page)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # status==0的时候代表新闻通过审核
    filters = [News.status == 0]

    if cid != 1:
        # 当查询条件不是1，不是最新新闻的时候，给条件列表添加条件
        filters.append(News.category_id == cid)
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(page, per_page, False)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')
    # 获取查询出来的数据
    items = paginate.items
    # 获取到总页数
    total_page = paginate.pages
    # 获取到当前页数
    current_page = paginate.page

    new_li = []

    for news in items:
        new_li.append(news.to_dict())

    data = {
        'total_page': total_page,
        'current_page': current_page,
        'new_li': new_li
    }
    return jsonify(errno=RET.OK, errmsg='OK', data=data)


@index_blu.route('/time.html')
def time_page():
    # status==0的时候代表新闻通过审核
    filters = [News.status == 0]
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(1, 10, False)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')

    # 获取查询出来的数据
    items = paginate.items
    # 获取到总页数
    total_page = paginate.pages
    # 获取到当前页数
    current_page = paginate.page

    new_li = []

    for news in items:
        new_li.append(news.to_dict())

    # 获取新闻分类数据
    categories = Category.query.all()
    # 定义列表保存分类数据
    categories_dicts = []

    for category in categories:
        # 拼接内容
        categories_dicts.append(category.to_dict())

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_index_dict())

    data = {
        'admin_dict': admin_dict[0],
        'new_li': new_li,
        'total_page': total_page,
        'current_page': current_page,
        'categories_dicts': categories_dicts
    }

    return render_template('time.html', data=data)


@index_blu.route('/about.html')
def about():
    # 获取新闻分类数据
    categories = Category.query.all()
    # 定义列表保存分类数据
    categories_dicts = []

    for category in categories:
        # 拼接内容
        categories_dicts.append(category.to_dict())

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_index_dict())

    data = {
        'admin_dict': admin_dict[0],
        'categories_dicts': categories_dicts
    }
    return render_template('about.html', data=data)


@index_blu.route('/gbook.html')
def gbook():
    # 获取新闻分类数据
    categories = Category.query.all()
    # 定义列表保存分类数据
    categories_dicts = []

    for category in categories:
        # 拼接内容
        categories_dicts.append(category.to_dict())

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_index_dict())

    data = {
        'admin_dict': admin_dict[0],
        'categories_dicts': categories_dicts,

    }
    return render_template('gbook.html', data=data)


@index_blu.route('/gbook3')
def gbook3():
    return render_template('gbook_new.html')


@index_blu.route('/add_gbook', methods=['post'])
def add_gbook():
    # 获取post请求参数
    nick_name = request.json.get('nick_name', None)
    email = request.json.get("email", None)
    content = request.json.get("content", None)
    # ip = request.remote_addr
    ip = request.headers['X-Real-IP']
    ua = request.headers.get('User-Agent')
    data_dic = get_ua(ua)
    browser = data_dic['browser']
    os_name = data_dic['os_name']

    # 1.1 判断数据是否有值
    if not content:
        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    # 判断是否恶意留言
    # 获取当前时间
    now = time.localtime()

    # 获取到今天的时间字符串
    today_date_str = ('%d-%02d-%02d' % (now.tm_year, now.tm_mon, now.tm_mday))
    # 转成时间对象
    today_date = datetime.strptime(today_date_str, '%Y-%m-%d')
    # 取道当天的0点0分
    begin_date = today_date - timedelta(days=0)
    # 取当天结束时间，也就是第二天的0点0分
    end_date = today_date - timedelta(days=-1)
    # 定义一个计数变量
    count = 0
    # 判断当天是否重复留言，且超过限制
    try:
        count = Gbook.query.filter(Gbook.ip == ip, Gbook.create_time >= begin_date, Gbook.update_time < end_date).count()
    except Exception as e:
        current_app.logger.error(e)

    if count >= 10:
        # 恶意刷留言
        print(count, ip)
        return jsonify(errno=RET.REQERR, errmsg='请勿恶意发布留言')

    print(count, ip)

    # 创建模型类对象
    gbook_obj = Gbook()

    # 3. 设置相关数据  过滤xss
    if nick_name:
        if '<' in nick_name or '>' in nick_name:
            nick_name = nick_name.replace('<', '(')
            nick_name = nick_name.replace('>', ')')
            gbook_obj.replyName = nick_name
        gbook_obj.replyName = nick_name
    if browser:
        gbook_obj.browser = browser
    if os_name:
        gbook_obj.os_name = os_name
    if email:
        if '<' in email or '>' in email:
            email = email.replace('<', '(')
            email = email.replace('>', ')')
            gbook_obj.email = email
        gbook_obj.email = email
    if ip:
        gbook_obj.ip = ip
    if content:
        if '<' in content or '>' in content:
            content = content.replace('<', '(')
            content = content.replace('>', ')')
            gbook_obj.content = content
        gbook_obj.content = content
    try:
        db.session.add(gbook_obj)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        jsonify(errno=RET.DBERR, errmsg='数据保存失败')

    return jsonify(errno=RET.OK, errmsg='留言发布成功')


@index_blu.route('/get_gbook')
def get_gbook():
    # 获取参数
    page = request.args.get('p', 1)

    # 校验参数
    try:
        page = int(page)
    except Exception as e:
        current_app.logger.error(e)
        page = 1

    gbooks_list = []
    current_page = 1
    total_page = 1

    try:
        paginate = Gbook.query.order_by(Gbook.create_time.desc()).paginate(page, constants.GUESTBOOK_PAGE_MAX_COUNT, False)
        gbooks_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)

    gbooks_dict = []

    for gbooks in gbooks_list:
        if gbooks.beReplyName:
            continue
        gbooks_dict.append(gbooks.to_dict())

    data = {
        'gbook_dict': gbooks_dict,
        'current_page': current_page,
        'total_page': total_page
    }

    return jsonify(data=data)
    # return render_template('gbook_new.html', data=data)


@index_blu.route('/news_list')
def news_list_page():
    """
    :return: 
    """
    # 1. 获取参数
    args_dict = request.args
    cid = args_dict.get("cid", '1')
    page = args_dict.get("page", '1')
    per_page = args_dict.get("per_page", constants.HOME_PAGE_MAX_NEWS)
    # 校验参数
    try:
        cid = int(cid)
        page = int(page)
        per_page = int(per_page)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # status==0的时候代表新闻通过审核
    filters = [News.status == 0]

    if cid != 1:
        # 当查询条件不是1，不是最新新闻的时候，给条件列表添加条件
        filters.append(News.category_id == cid)
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(page, per_page, False)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')
    # 获取查询出来的数据
    items = paginate.items
    # 获取到总页数
    total_page = paginate.pages
    # 获取到当前页数
    current_page = paginate.page

    new_li = []

    for news in items:
        new_li.append(news.to_dict())

    data = {
        'total_page': total_page,
        'current_page': current_page,
        'new_li': new_li
    }
    return jsonify(errno=RET.OK, errmsg='OK', data=data)


@index_blu.route('/')
def index():
    # 新闻点击排行信息
    news_list = []
    # 按点击量查询并且返回6条数据
    try:
        news_list = News.query.order_by(News.clicks.desc()).limit(5)
    except Exception as e:
        current_app.logger.error(e)
    news_dict_list = []
    for news in news_list:
        news_dict_list.append(news.to_basic_dict())

    # status==0的时候代表新闻通过审核
    filters = [News.status == 0]


    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(1, 10, False)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')

    try:
        # 通过第三张表来快速查询被推荐的文章
        all_action_news = NewsAction.query.order_by(NewsAction.create_time.desc())
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')

    # 轮播图文章
    banner_news = []
    # 置顶图文
    top_news = []
    # 特别推荐 首页不需要，所以注释
    # tuijian_news = []
    for news in all_action_news:
        if not news.news_id:
            # 如果新闻被删除，则删除关联的推荐
            try:
                db.session.delete(news)
                db.session.commit()
            except Exception as e:
                db.session.rollback()
                current_app.logger.error(e)
            continue
        # 根据action属性将文章加入不同列表
        # 从第三张表查出数据，根据relationship获取到对应的文章对象
        # 然后使用to_dict转成字典传给前端
        if news.is_banner:
            # print(news.news_action.title)
            banner_news.append(news.news_action.to_dict())
        if news.is_top:
            # print(news.news_action.title)
            if len(top_news) < 2:
                top_news.append(news.news_action.to_dict())
        # if news.is_tuijian:
        #     print(news.news_action.title)
        #     tuijian_news.append(news.news_action.to_dict())

    # 获取查询出来的数据
    items = paginate.items
    # 获取到总页数
    total_page = paginate.pages
    # 获取到当前页数
    current_page = paginate.page

    new_li = []

    for news in items:
        new_li.append(news.to_dict())

    # 获取新闻分类数据
    categories = Category.query.all()
    # 定义列表保存分类数据
    categories_dicts = []

    for category in categories:
        # 拼接内容
        categories_dicts.append(category.to_dict())

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_index_dict())

    # 查询友情链接的数据
    links = []
    try:
        links = Link.query.all()
    except Exception as e:
        current_app.logger.error(e)

    links_li = []
    for category in links:
        links_li.append(category.to_dict())

    data = {
        'admin_dict': admin_dict[0],
        'new_li': new_li,
        'news_dict_list': news_dict_list,
        'total_page': total_page,
        'current_page': current_page,
        'categories_dicts': categories_dicts,
        'banner_news': banner_news,
        'top_news': top_news,
        'links_li': links_li,
    }

    return render_template('index.html', data=data)


@index_blu.route('/favicon.ico')
def favicon():
    return current_app.send_static_file('news/favicon.ico')

