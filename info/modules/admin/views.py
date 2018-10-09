import os
import random
import time
from datetime import datetime, timedelta
from flask import render_template, session, request, current_app, redirect, url_for, g, jsonify, abort, make_response
from info import constants, db
from info.models import User, News, Category, AdminUser, NewsAction, Comment, Gbook, Link
from info.utils.common import user_login_data
from info.utils.image_storage import storage
from info.utils.response_code import RET
from . import admin_blu
from config import BASE_DIR


def gen_rnd_filename():
    filename_prefix = datetime.now().strftime('%Y%m%d%H%M%S')
    return '%s%s' % (filename_prefix, str(random.randrange(1000, 10000)))


@admin_blu.route('/ckupload/', methods=['POST', 'OPTIONS'])
def ckupload():
    """CKEditor file upload"""
    error = ''

    if request.method == 'POST' and 'upload' in request.files:
        fileobj = request.files['upload']
        fname, fext = os.path.splitext(fileobj.filename)
        rnd_name = '%s%s' % (gen_rnd_filename(), fext)

        filepath = os.path.join(BASE_DIR, 'info/static/upload', rnd_name)

        # 检查路径是否存在，不存在则创建
        dirname = os.path.dirname(filepath)
        if not os.path.exists(dirname):
            try:
                os.makedirs(dirname)
            except Exception as e:
                error = e
        elif not os.access(dirname, os.W_OK):
            error = 'ERROR_DIR_NOT_WRITEABLE'

        if not error:
            fileobj.save(filepath)
            url = url_for('static', filename='%s/%s' % ('upload', rnd_name))
            return jsonify({"uploaded": 1, "fileName": rnd_name, "url": url})
        else:
            return jsonify({"uploaded": 0, "error": {"errormessage": error}})


@admin_blu.route('/admin_links_del', methods=['post'])
@user_login_data
def admin_links_del():
    """删除友情链接"""

    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    lid = request.json.get('id')

    try:
        lid = int(lid)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数错误')

    if not lid:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        links = Link.query.get(lid)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据库查询失败')

    if not links:
        return jsonify(errno=RET.NODATA, errmsg='不存在该友情链接')

    try:
        db.session.delete(links)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='保存数据库失败')

    return jsonify(errno=RET.OK, errmsg='ok')


@admin_blu.route('/admin_links', methods=['get', 'post'])
@user_login_data
def admin_links():

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 查询友情链接的数据
        links = []
        try:
            links = Link.query.all()
        except Exception as e:
            current_app.logger.error(e)

        links_li = []
        for category in links:
            links_li.append(category.to_dict())

        # 返回数据
        data = {
            "links_li": links_li
        }
        return render_template('admin/admin_links.html', data=data)

    # 获取post提交的参数
    """修改或者添加友情链接"""

    lid = request.json.get("id")
    lname = request.json.get("name")
    lurl = request.json.get("url")

    if not all([lname, lurl]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")

    if 'http' not in lurl:
        lurl = 'http://' + lurl + '/'

    # 判断是否有友情链接id
    if lid:
        try:
            lid = int(lid)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数错误")
        try:
            link = Link.query.get(lid)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.DBERR, errmsg="查询数据失败")

        if not link:
            return jsonify(errno=RET.NODATA, errmsg="未查询到友情链接信息")

        link.name = lname
        link.url = lurl
    else:
        # 如果没有友情链接id，则是添加友情链接
        link = Link()
        link.name = lname
        link.url = lurl
        db.session.add(link)

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/gbook_reply', methods=['post'])
@user_login_data
def gbook_reply():
    """回复留言"""
    user = g.user
    if not user.is_admin:
        return render_template('/')

    # 获取post提交的参数
    """修改或者添加分类"""

    gbook_id = request.json.get("id")
    content = request.json.get("content")

    if not all([gbook_id, content]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")

    try:
        gbook_id = int(gbook_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")

    try:
        gbook = Gbook.query.get(gbook_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询留言失败')

    if not gbook:
        abort(404)

    reply_gbook = Gbook()

    reply_gbook.beReplyName = gbook.replyName
    reply_gbook.content = content
    reply_gbook.replyName = 'admin'

    try:
        db.session.add(reply_gbook)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        jsonify(errno=RET.DBERR, errmsg='数据保存失败')

    gbook.son_id = reply_gbook.id

    return jsonify(errno=RET.OK, errmsg='ok')


@admin_blu.route('/gbook_delete', methods=['get', 'post'])
@user_login_data
def gbook_delete():
    """彻底删除留言，从数据库中删除"""
    user = g.user
    if not user.is_admin:
        return render_template('/')

    # 获取参数
    gbook_id = request.args.get('gbook_id')

    if not gbook_id:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        gbook_id = int(gbook_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    try:
        gbook = Gbook.query.get(gbook_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询留言失败')

    if not gbook:
        abort(404)

    # TODO 删除回复评论时需先删除主评论，或者将主评论的son_id字段管理的外键清空
    # parent_gbook = Gbook.query.filter(Gbook.son_id==gbook_id).all()#.first()
    # parent_gbook = db.session.query(Gbook)#.filter(Gbook.son_id==gbook_id).first()
    # print(parent_gbook)
    # parent_gbook.son_id = None
    # try:
    #     db.session.delete()
    #     db.session.commit()
    # except Exception as e:
    #     db.session.rollback()
    #     current_app.logger.error(e)
    #     return jsonify(errno=RET.DBERR, errmsg='清除主键id失败')

    try:
        db.session.delete(gbook)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='删除留言失败')

    return redirect(url_for('admin.gbook_edit'))


@admin_blu.route('/gbook_edit')
@user_login_data
def gbook_edit():
    """留言管理：删除和回复"""

    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    page = request.args.get('p', 1)
    keywords = request.args.get('keywords', None)
    # 校验参数
    try:
        page = int(page)
    except Exception as e:
        current_app.logger.error(e)
        page = 1

    gbook_list = []
    current_page = 1
    total_page = 1

    filters = [Gbook.id > 0]

    if keywords:
        # 如果有关键字，将关键字假如过滤
        filters.append(Gbook.content.contains(keywords))

    # 查询statu状态为0的文章
    try:
        paginate = Gbook.query.filter(*filters).order_by(Gbook.create_time.desc()).paginate(page, constants.ADMIN_NEWS_PAGE_MAX_COUNT, False)
        gbook_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)

    gbook_dict = []

    for gbook in gbook_list:
        gbook_dict.append(gbook.to_dict())

    context = {
        'gbook_list': gbook_list,
        'current_page': current_page,
        'total_page': total_page
    }

    return render_template('admin/gbook_edit.html', data=context)


@admin_blu.route('/news_real_delete', methods=['get', 'post'])
@user_login_data
def news_real_delete():
    """彻底删除文章，从数据库中删除"""
    user = g.user
    if not user.is_admin:
        return render_template('/')

    # 获取参数
    news_id = request.args.get('news_id')

    if not news_id:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        news_id = int(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询文章失败')

    if not news:
        abort(404)

    # TODO 从数据库彻底删除文章需要先删除已关联的外键, 删除推荐即可，评论已级联删除
    news_action = NewsAction.query.filter(NewsAction.news_id == news_id).first()

    try:
        if news_action:
            db.session.delete(news_action)
        db.session.delete(news)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='删除文章失败')

    return redirect(url_for('admin.news_trash'))


@admin_blu.route('/news_replay')
@user_login_data
def news_replay():
    """恢复删除文章，设置status为0"""
    user = g.user
    if not user.is_admin:
        return render_template('/')

    # 获取参数
    news_id = request.args.get('news_id')

    if not news_id:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        news_id = int(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询新闻失败')

    if not news:
        abort(404)

    news.status = 0

    return redirect(url_for('admin.news_trash'))


@admin_blu.route('/news_trash', methods=['get', 'post'])
@user_login_data
def news_trash():
    """文章回收站，展示status为1的文章，彻底删除或恢复显示"""
    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    page = request.args.get('p', 1)
    keywords = request.args.get('keywords', None)
    # 校验参数
    try:
        page = int(page)
    except Exception as e:
        current_app.logger.error(e)
        page = 1

    news_list = []
    current_page = 1
    total_page = 1

    filters = [News.status == 1]

    if keywords:
        # 如果有关键字，将关键字假如过滤
        filters.append(News.title.contains(keywords))

    # 查询statu状态为0的文章
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(page, constants.ADMIN_NEWS_PAGE_MAX_COUNT, False)
        news_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)

    news_dict = []

    for news in news_list:
        news_dict.append(news.to_basic_dict())

    context = {
        'news_dict': news_dict,
        'current_page': current_page,
        'total_page': total_page
    }

    return render_template('admin/news_trash.html', data=context)


@admin_blu.route('/news_delete', methods=['get', 'post'])
@user_login_data
def news_delete():
    """逻辑删除文章，设置status为1"""
    user = g.user
    if not user.is_admin:
        return render_template('/')

    # 获取参数
    news_id = request.args.get('news_id')

    if not news_id:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        news_id = int(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询新闻失败')

    if not news:
        abort(404)

    news.status = 1

    return redirect(url_for('admin.news_edit'))


@admin_blu.route('/add_news', methods=['get', 'post'])
@user_login_data
def add_news():
    """新闻编辑详情页"""

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 查询分类的数据
        categories = []
        try:
            categories = Category.query.all()
        except Exception as e:
            current_app.logger.error(e)

        categories_li = []
        for category in categories:
            c_dict = category.to_dict()
            c_dict["is_selected"] = False
            if category.id == 1:
                c_dict["is_selected"] = True

            categories_li.append(c_dict)

        # 返回数据
        data = {
            "categories": categories_li
        }
        return render_template('admin/add_news.html', data=data)

    # 获取post请求参数
    title = request.form.get("title")
    digest = request.form.get("digest")
    content = request.form.get("content")
    index_image = request.files.get("index_image")
    category_id = request.form.get("category_id")
    source = request.form.get("source")
    # 1.1 判断数据是否有值
    if not all([title, digest, content, category_id, source]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    # 查询指定id的新闻
    news = News()

    # 1.2 尝试读取图片
    if index_image:
        try:
            index_image = index_image.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(index_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        news.index_image_url = constants.QINIU_DOMIN_PREFIX + key

    # 3. 设置相关数据
    news.title = title
    news.digest = digest
    news.content = content
    news.category_id = category_id
    news.source = source

    try:
        db.session.add(news)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='存储数据失败')

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/change_action', methods=['post'])
@user_login_data
def change_action():
    """给文章增加action状态，标明是否推荐"""
    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    params = request.json
    news_id = params.get('news_id')
    action_type = params.get("action_type")
    action = params.get("action")
    # 校验参数
    if not all([news_id, action_type, action]):
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    if action not in ('add', 'remove'):
        return jsonify(errno=RET.PARAMERR, errmsg='action参数错误')

    try:
        news_id = int(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # 通过id查询数据库模型对象
    try:
        news = NewsAction.query.filter(NewsAction.news_id == news_id).first()
        print(news)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='查询失败')

    # 定义一个标记
    flag = None

    if not news:
        # 记录第一次添加推荐状态，创建一个模型对象
        news = NewsAction()
        flag = True

    news.news_id = news_id

    if action == 'add':
        if action_type == 'banner':
            news.is_banner = True
        if action_type == 'top':
            news.is_top = True
        if action_type == 'tuijian':
            news.is_tuijian = True
    else:
        if action_type == 'banner':
            news.is_banner = False
        if action_type == 'top':
            news.is_top = False
        if action_type == 'tuijian':
            news.is_tuijian = False

    # 提交到数据库
    try:
        # 根据不同的状态执行不同的数据库操作
        if flag:
            db.session.add(news)
            db.session.commit()
            # print('创建新对象')
        else:
            # 如果推荐状态全部取消则删除对象
            if not news.is_top and not news.is_tuijian and not news.is_banner:
                # print('删除对象')
                db.session.delete(news)
            db.session.commit()
            # print('修改对象成功')
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据提交失败')

    return jsonify(errno=RET.OK, errmsg='ok')


@admin_blu.route('/add_action')
@user_login_data
def add_action():
    """给文章增加action状态，标明是否推荐"""
    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    page = request.args.get('p', 1)
    keywords = request.args.get('keywords', None)
    # 校验参数
    try:
        page = int(page)
    except Exception as e:
        current_app.logger.error(e)
        page = 1

    news_list = []
    current_page = 1
    total_page = 1

    filters = [News.status == 0]

    if keywords:
        # 如果有关键字，将关键字假如过滤
        filters.append(News.title.contains(keywords))

    # 查询statu状态为0的文章
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(page, constants.ADMIN_NEWS_PAGE_MAX_COUNT, False)
        news_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)


    try:
        # 通过第三张表来快速查询被推荐的文章
        all_action_news = NewsAction.query.all()
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')

    # 轮播图文章
    banner_news = []
    # 置顶图文
    top_news = []
    # 特别推荐
    tuijian_news = []
    for news in all_action_news:
        # 根据action属性将文章加入不同列表
        # 从第三张表查出数据，根据relationship获取到对应的文章对象
        if news.is_banner:
            # print(news.news_action.title)
            # banner_news.append(news.news_action.id)
            banner_news.append(news.news_id)
        if news.is_top:
            # print(news.news_action.title)
            # top_news.append(news.news_action.id)
            top_news.append(news.news_id)
        if news.is_tuijian:
            # print(news.news_action.title)
            # tuijian_news.append(news.news_action.id)
            tuijian_news.append(news.news_id)
    news_dict = []

    for news in news_list:
        news_dict.append(news.to_basic_dict())

    context = {
        'news_dict': news_dict,
        'current_page': current_page,
        'total_page': total_page,
        'banner_news': banner_news,
        'top_news': top_news,
        'tuijian_news': tuijian_news,
    }

    return render_template('admin/add_action.html', data=context)


@admin_blu.route('/user_delete')
@user_login_data
def user_delete():
    """删除管理员"""
    if not g.user.is_admin:
        return redirect('/')
    # 获取参数
    admin_id = request.args.get('admin_id')
    if not admin_id:
        abort(404)
    try:
        admin_id = int(admin_id)
    except Exception as e:
        current_app.logger.error(e)
        return render_template('admin/news_review_detail.html', data={"errmsg": "参数错误"})
    # 通过id查询新闻
    try:
        user = User.query.get(admin_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据查询失败')

    try:
        db.session.delete(user)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据删除失败')

    # 返回结果
    return redirect(url_for('admin.admin_user_edit'))


@admin_blu.route('/admin_add', methods=['get', 'post'])
@user_login_data
def admin_add():
    """新增管理员"""
    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        return render_template('admin/admin_add_user.html')

    # 获取post请求参数
    nick_name = request.form.get("nick_name")
    password = request.form.get("password")
    password2 = request.form.get("password2")
    mobile = request.form.get("mobile")
    signature = request.form.get("signature")
    gender = request.form.get("gender")
    avatar_url = request.files.get("avatar_url")

    # 1.1 判断数据是否有值
    if not all([nick_name, password, password2, mobile, gender]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    if password != password2:
        return jsonify(errno=RET.PARAMERR, errmsg="两次密码不一致")

    if User.query.filter(User.nick_name == nick_name or User.mobile == mobile).first():
        return jsonify(errno=RET.PARAMERR, errmsg="用户名或者手机号已存在")

    # 创建用户模型对象
    user = User()

    # 1.2 尝试读取图片
    if avatar_url:
        try:
            avatar_image = avatar_url.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(avatar_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        user.avatar_url = constants.QINIU_DOMIN_PREFIX + key

    # 3. 设置相关数据
    user.nick_name = nick_name
    user.password = password
    user.mobile = mobile
    user.signature = signature
    user.gender = gender
    user.is_admin = 1

    try:
        db.session.add(user)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据存储失败')

    # 返回结果
    return jsonify(errno=RET.OK, errmsg='管理员用户创建成功')


@admin_blu.route('/admin_user_detail', methods=['get', 'post'])
@user_login_data
def admin_user_detail():
    """管理员信息编辑详情页"""

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 获取参数
        admin_id = request.args.get('admin_id')
        if not admin_id:
            abort(404)
        try:
            admin_id = int(admin_id)
        except Exception as e:
            current_app.logger.error(e)
            return render_template('admin/admin_text_edit.html', data={"errmsg": "参数错误"})
        # 通过id查询新闻
        admin_user_dict = None
        try:
            admin_user_dict = User.query.get(admin_id)
        except Exception as e:
            current_app.logger.error(e)

        if not admin_user_dict:
            return render_template('admin/admin_text_edit.html', data={"errmsg": "未查询到此配置信息"})

        # 返回数据
        data = {
            "admin_user_dict": admin_user_dict.to_dict(),
        }
        return render_template('admin/admin_user_detail.html', data=data)

    # 获取post请求参数
    admin_id = request.form.get("admin_id")
    nick_name = request.form.get("nick_name")
    password = request.form.get("password")
    mobile = request.form.get("mobile")
    signature = request.form.get("signature")
    gender = request.form.get("gender")
    avatar_url = request.files.get("avatar_url")

    # 1.1 判断数据是否有值
    if not all([nick_name, admin_id, mobile, gender]):

        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    # 查询指定id的新闻
    try:
        user = User.query.get(admin_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")
    if not user:
        return jsonify(errno=RET.NODATA, errmsg="未查询到新闻数据")

    # 1.2 尝试读取图片
    if avatar_url:
        try:
            wxcode_image = avatar_url.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(wxcode_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        user.avatar_url = constants.QINIU_DOMIN_PREFIX + key

    if password:
        user.password = password

    # 3. 设置相关数据
    user.nick_name = nick_name
    user.mobile = mobile
    user.signature = signature
    user.gender = gender

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/admin_user_edit')
@user_login_data
def admin_user_edit():
    """管理员信息编辑管理页"""

    if not g.user.is_admin:
        return redirect('/')

    users = User.query.all()
    admin_user = []
    for user in users:
        if user.is_admin:
            admin_user.append(user.to_admin_dict())

    data = {
        'admin_user': admin_user,
    }
    return render_template('admin/admin_user_edit.html', data=data)


@admin_blu.route('/admin_edit_detail', methods=['get', 'post'])
@user_login_data
def admin_edit_detail():
    """站点信息编辑详情页"""

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 获取参数
        admin_id = request.args.get('admin_id')
        if not admin_id:
            abort(404)
        try:
            admin_id = int(admin_id)
        except Exception as e:
            current_app.logger.error(e)
            return render_template('admin/admin_text_edit.html', data={"errmsg": "参数错误"})
        # 通过id查询新闻
        admin_dict = None
        try:
            admin_dict = AdminUser.query.get(admin_id)
        except Exception as e:
            current_app.logger.error(e)

        if not admin_dict:
            return render_template('admin/admin_text_edit.html', data={"errmsg": "未查询到此配置信息"})

        # 返回数据
        data = {
            "admin_dict": admin_dict.to_dict(),
        }
        # tag_str = ''
        # # 爬虫,Django,flask,Python,sec,灰帽,安全,数据统计,佛系程序员,wooyun,搬砖,apt,原创,个人博客,web渗透,内网渗透,数据分析,伪黑阔,黑盒测试,灰盒测试,内网杀手
        # for tag in admin_dict.to_dict()['tags']:
        #     tag_str += (tag)
        #     tag_str += ','
        #
        # print(tag_str)
        return render_template('admin/admin_edit_detail.html', data=data)

    # 获取post请求参数
    admin_id = request.form.get("admin_id")
    title = request.form.get("title")
    description = request.form.get("description")
    keywords = request.form.get("keywords")
    logo_name = request.form.get("logo_name")
    tags = request.form.get("tags")
    email = request.form.get("email")
    qq = request.form.get("qq")
    wxid = request.form.get("wxid")
    wxcode = request.files.get("wxcode")
    butoom_title = request.form.get("butoom_title")
    beian = request.form.get("beian")
    about_me = request.form.get("content")
    card_name = request.form.get("card_name")
    card_job = request.form.get("card_job")
    card_about = request.form.get("card_about")
    card_avatar = request.files.get("card_avatar")

    # 1.1 判断数据是否有值
    if not all([title, admin_id, description, keywords, logo_name, email, wxid, butoom_title, beian, about_me, card_name, card_job, card_about]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    # 查询指定id的新闻
    try:
        admin_text = AdminUser.query.get(admin_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")
    if not admin_text:
        return jsonify(errno=RET.NODATA, errmsg="未查询到新闻数据")

    # 1.2 尝试读取图片
    if wxcode:
        try:
            wxcode_image = wxcode.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(wxcode_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        admin_text.wxcode = constants.QINIU_DOMIN_PREFIX + key

    if card_avatar:
        try:
            card_avatar_image = card_avatar.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(card_avatar_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        admin_text.card_avatar = constants.QINIU_DOMIN_PREFIX + key

    # 3. 设置相关数据
    admin_text.title = title
    admin_text.description = description
    admin_text.keywords = keywords
    admin_text.email = email
    admin_text.qq = qq
    admin_text.logo_name = logo_name
    admin_text.tags = tags
    admin_text.wxid = wxid
    admin_text.butoom_title = butoom_title
    admin_text.beian = beian
    admin_text.about_me = about_me
    admin_text.card_name = card_name
    admin_text.card_job = card_job
    admin_text.card_about = card_about

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/admin_text_edit')
@user_login_data
def admin_text_edit():
    """系统信息编辑管理页"""

    if not g.user.is_admin:
        return redirect('/')

    admin_dict = []
    admin_user = AdminUser.query.all()
    for admin_text in admin_user:
        admin_dict.append(admin_text.to_dict())

    data = {
        'admin_dict': admin_dict,
    }

    return render_template('admin/admin_text_edit.html', data=data)


@admin_blu.route('/news_type_del', methods=['post'])
@user_login_data
def news_type_del():
    """删除分类"""

    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    cid = request.json.get('id')

    try:
        cid = int(cid)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数错误')

    if not cid:
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    try:
        categories = Category.query.get(cid)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据库查询失败')

    if not categories:
        return jsonify(errno=RET.NODATA, errmsg='不存在该分类')

    try:
        db.session.delete(categories)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='保存数据库失败')

    return jsonify(errno=RET.OK, errmsg='ok')


@admin_blu.route('/news_type', methods=['get', 'post'])
@user_login_data
def news_type():

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 查询分类的数据
        categories = []
        try:
            categories = Category.query.all()
        except Exception as e:
            current_app.logger.error(e)

        categories_li = []
        for category in categories:
            # if category.id == 1:
            #     continue
            categories_li.append(category.to_dict())

        # 返回数据
        data = {
            "categories": categories_li
        }
        return render_template('admin/news_type.html', data=data)

    # 获取post提交的参数
    """修改或者添加分类"""

    cid = request.json.get("id")
    cname = request.json.get("name")
    if not cname:
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")

    # 判断是否有分类id
    if cid:
        try:
            cid = int(cid)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数错误")
        try:
            category = Category.query.get(cid)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.DBERR, errmsg="查询数据失败")

        if not category:
            return jsonify(errno=RET.NODATA, errmsg="未查询到分类信息")

        category.name = cname
    else:
        # 如果没有分类id，则是添加分类
        category = Category()
        category.name = cname
        db.session.add(category)

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/news_edit_detail', methods=['get', 'post'])
@user_login_data
def news_edit_detail():
    """新闻编辑详情页"""

    if not g.user.is_admin:
        return redirect('/')

    if request.method == 'GET':
        # 获取参数
        news_id = request.args.get('news_id')
        if not news_id:
            abort(404)

        try:
            news_id = int(news_id)
        except Exception as e:
            current_app.logger.error(e)
            return render_template('admin/admin_text_edit.html', data={"errmsg": "参数错误"})
        # 通过id查询新闻
        news = None
        try:
            news = News.query.get(news_id)
        except Exception as e:
            current_app.logger.error(e)

        if not news:
            return render_template('admin/admin_text_edit.html', data={"errmsg": "未查询到此新闻"})

        # 查询分类的数据
        categories = []
        try:
            categories = Category.query.all()
        except Exception as e:
            current_app.logger.error(e)

        categories_li = []
        for category in categories:
            # if category.id == 1:
            #     continue
            c_dict = category.to_dict()
            c_dict["is_selected"] = False
            if category.id == news.category_id:
                c_dict["is_selected"] = True
            categories_li.append(c_dict)

        # 返回数据
        data = {
            "news": news.to_dict(),
            "categories": categories_li
        }
        return render_template('admin/news_edit_detail.html', data=data)

    # 获取post请求参数
    news_id = request.form.get("news_id")
    title = request.form.get("title")
    digest = request.form.get("digest")
    content = request.form.get("content")
    index_image = request.files.get("index_image")
    category_id = request.form.get("category_id")
    source = request.form.get("source")
    # 1.1 判断数据是否有值
    if not all([title, digest, content, category_id, source]):
        return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

    # 查询指定id的新闻
    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg="参数错误")
    if not news:
        return jsonify(errno=RET.NODATA, errmsg="未查询到新闻数据")

    # 1.2 尝试读取图片
    if index_image:
        try:
            index_image = index_image.read()
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.PARAMERR, errmsg="参数有误")

        # 2. 将标题图片上传到七牛
        try:
            key = storage(index_image)
        except Exception as e:
            current_app.logger.error(e)
            return jsonify(errno=RET.THIRDERR, errmsg="上传图片错误")
        news.index_image_url = constants.QINIU_DOMIN_PREFIX + key

    # 3. 设置相关数据
    news.title = title
    news.digest = digest
    news.content = content
    news.category_id = category_id
    news.source = source

    return jsonify(errno=RET.OK, errmsg='OK')


@admin_blu.route('/news_edit')
@user_login_data
def news_edit():
    """编辑新闻"""

    if not g.user.is_admin:
        return redirect('/')

    # 获取参数
    page = request.args.get('p', 1)
    keywords = request.args.get('keywords', None)
    # 校验参数
    try:
        page = int(page)
    except Exception as e:
        current_app.logger.error(e)
        page = 1

    news_list = []
    current_page = 1
    total_page = 1

    filters = [News.status == 0]

    if keywords:
        # 如果有关键字，将关键字假如过滤
        filters.append(News.title.contains(keywords))

    # 查询statu状态为0的文章
    try:
        paginate = News.query.filter(*filters).order_by(News.create_time.desc()).paginate(page, constants.ADMIN_NEWS_PAGE_MAX_COUNT, False)
        news_list = paginate.items
        current_page = paginate.page
        total_page = paginate.pages
    except Exception as e:
        current_app.logger.error(e)

    news_dict = []

    for news in news_list:
        news_dict.append(news.to_basic_dict())

    context = {
        'news_dict': news_dict,
        'current_page': current_page,
        'total_page': total_page
    }

    return render_template('admin/news_edit.html', data=context)


@admin_blu.route('/news_count')
@user_login_data
def news_count():
    """返回文章数量"""

    if not g.user.is_admin:
        return redirect('/')

    # 查询总数
    total_count = 0
    try:
        total_count = News.query.filter(News.status == 0).count()
    except Exception as e:
        current_app.logger.error(e)

    # 获取当前时间
    now = time.localtime()
    # 查询月新增数
    mon_count = 0
    try:
        mon_begin = '%d-%02d-01' % (now.tm_year, now.tm_mon)
        mon_begin_date = datetime.strptime(mon_begin, '%Y-%m-%d')
        mon_count = News.query.filter(News.status == 0, News.create_time >= mon_begin_date).count()
    except Exception as e:
        current_app.logger.error(e)

    # 查询日新增数
    day_count = 0
    try:
        day_begin = '%d-%02d-%02d' % (now.tm_year, now.tm_mon, now.tm_mday)
        day_begin_date = datetime.strptime(day_begin, '%Y-%m-%d')
        day_count = News.query.filter(News.status == 0, News.create_time > day_begin_date).count()
    except Exception as e:
        current_app.logger.error(e)

    # 查询图表信息
    # 获取到当天00:00:00时间

    # 获取到今天的时间字符串
    today_date_str = ('%d-%02d-%02d' % (now.tm_year, now.tm_mon, now.tm_mday))
    # 转成时间对象
    today_date = datetime.strptime(today_date_str, '%Y-%m-%d')

    # 定义空数组，保存数据
    active_date = []
    active_count = []

    # 依次添加数据，再反转
    for i in range(0, 31):
        # 取道当天的0点0分
        begin_date = today_date - timedelta(days=i)
        # 取道前一天的0点0分
        end_date = today_date - timedelta(days=(i - 1))
        active_date.append(begin_date.strftime('%Y-%m-%d'))
        count = 0
        try:
            count = News.query.filter(News.status == 0, News.create_time, News.update_time >= begin_date,
                                      News.update_time < end_date).count()
        except Exception as e:
            current_app.logger.error(e)
        active_count.append(count)

    active_date.reverse()
    active_count.reverse()

    data = {
        'total_count': total_count,
        'mon_count': mon_count,
        'day_count': day_count,
        'active_date': active_date,
        'active_count': active_count
    }

    return render_template('admin/news_count.html', data=data)


@admin_blu.route('/index')
@user_login_data
def admin_index():
    user = g.user
    if not user.is_admin:
        return redirect('/')

    return render_template('admin/index.html', user=user.to_dict())


@admin_blu.route('/login', methods=["GET", "POST"])
def admin_login():
    if request.method == "GET":
        # 去 session 中取指定的值
        user_id = session.get("user_id", None)
        is_admin = session.get("is_admin", False)
        # 如果用户id存在，并且是管理员，那么直接跳转管理后台主页
        if user_id and is_admin:
            return redirect(url_for('admin.admin_index'))
        return render_template('admin/login.html')

    # 取到登录的参数
    username = request.form.get("username")
    password = request.form.get("password")
    if not all([username, password]):
        return render_template('admin/login.html', errmsg="参数不足")

    try:
        user = User.query.filter(User.mobile == username or User.nick_name == username).first()
    except Exception as e:
        current_app.logger.error(e)
        return render_template('admin/login.html', errmsg="数据查询失败")

    if not user:
        return render_template('admin/login.html', errmsg="用户不存在")

    if not user.check_passowrd(password):
        return render_template('admin/login.html', errmsg="密码错误")

    if not user.is_admin:
        return render_template('admin/login.html', errmsg="用户权限错误")

    session["user_id"] = user.id
    session["nick_name"] = user.nick_name
    session["mobile"] = user.mobile
    session["is_admin"] = True

    #  跳转到后台管理主页,
    return redirect(url_for('admin.admin_index'))
