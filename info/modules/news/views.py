from info import db
from info.models import User, News, Comment, Category, AdminUser, NewsAction
from info.utils.common import user_login_data
from info.utils.response_code import RET
from . import news_blu
from flask import render_template, session, current_app, g, abort, request, jsonify


@news_blu.route('/<int:news_id>')
def news_detail(news_id):
    """新闻详情页"""

    # 点击排行信息
    news_list = []
    # 按点击量查询并且返回5条数据
    try:
        news_list = News.query.order_by(News.clicks.desc()).limit(5)
    except Exception as e:
        current_app.logger.error(e)
    news_dict_list = []
    for news in news_list:
        news_dict_list.append(news.to_basic_dict())

    # 特别推荐
    try:
        # 通过第三张表来快速查询被推荐的文章
        all_action_news = NewsAction.query.all()
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='新闻数据查询失败')

    tuijian_news = []

    for news in all_action_news:
        # 根据action属性将文章加入不同列表
        if news.is_tuijian:
            # 从第三张表查出数据，根据relationship获取到对应的文章对象
            # 然后使用to_dict转成字典传给前端
            # new = News.query.get(news.news_id)
            # tuijian_news.append(new.to_dict())
            tuijian_news.append(news.news_action.to_dict())

    news = None
    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        abort(404)

    if not news:
        # 返回数据未找到的页面
        abort(404)

    news.clicks += 1

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

    comments = []
    try:
        comments = Comment.query.filter(Comment.news_id == news_id).order_by(Comment.create_time.desc()).all()
    except Exception as e:
        current_app.logger.error(e)

    comment_list = []

    for comment in comments:
        comment_dict = comment.to_dict()
        comment_list.append(comment_dict)

    data = {
        'admin_dict': admin_dict[0],
        'news': news.to_dict(),
        "news_dict_list": news_dict_list,
        'categories_dicts': categories_dicts,
        'comments': comment_list,
        'tuijian_news': tuijian_news,
    }
    return render_template('info.html', data=data)


@news_blu.route('/news_comment', methods=['POST'])
def comment_news():
    """文章评论"""

    # 获取参数
    params = request.json
    news_id = params.get('news_id')
    comment_content = params.get("comment")
    parent_id = params.get("parent_id")

    # 过滤尖括号，防止xss
    if '<' or '>' in comment_content:
        comment_content = comment_content.replace('<', '(')
        comment_content = comment_content.replace('>', ')')

    if not all([news_id, comment_content]):
        return jsonify(errno=RET.PARAMERR, errmsg='参数错误')

    try:
        news_id = int(news_id)
        if parent_id:
            parent_id = int(parent_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # 查询新闻数据，判断新闻是否存在
    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='数据查询失败')

    if not news:
        return jsonify(errno=RET.NODATA, errmsg='新闻数据不存在')

    # 初始化评论模型
    comment = Comment()
    comment.news_id = news_id
    comment.content = comment_content
    if parent_id:
        comment.parent_id = parent_id

    # 提交到数据库
    try:
        db.session.add(comment)
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)

    return jsonify(errno=RET.OK, errmsg='ok', data=comment.to_dict())


@news_blu.route('/comment_like', methods=['POST'])
def comment_like():
    """评论点赞"""

    # 获取参数
    params = request.json
    news_id = params.get('news_id')
    comment_id = params.get("comment_id")
    action = params.get("action")
    # 校验参数
    if not all([news_id, comment_id, action]):
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    if action not in ('add', 'remove'):
        return jsonify(errno=RET.PARAMERR, errmsg='action参数错误')

    try:
        news_id = int(news_id)
        comment_id = int(comment_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # 通过评论id查询评论模型
    try:
        comments = Comment.query.get(comment_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='评论查询失败')

    if not comments:
        return jsonify(errno=RET.NODATA, errmsg='评论不存在')

    if action == 'add':
        comments.like_count += 1
    else:
        comments.like_count -= 1

    # 提交到数据库
    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='点赞评论查询失败')

    return jsonify(errno=RET.OK, errmsg='ok')


@news_blu.route('/news_like', methods=['POST'])
def news_like():
    """评论点赞"""

    # 获取参数
    params = request.json
    news_id = params.get('news_id')
    action = params.get("action")
    # 校验参数
    if not all([news_id, action]):
        return jsonify(errno=RET.PARAMERR, errmsg='参数不足')

    if action not in ('add', 'remove'):
        return jsonify(errno=RET.PARAMERR, errmsg='action参数错误')

    try:
        news_id = int(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.PARAMERR, errmsg='参数类型错误')

    # 通过评论id查询评论模型
    try:
        news = News.query.get(news_id)
    except Exception as e:
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='评论查询失败')

    if not news:
        return jsonify(errno=RET.NODATA, errmsg='评论不存在')

    if not news.like_count:
        news.like_count = 0

    if action == 'add':
        news.like_count += 1
    else:
        news.like_count -= 1

    # 提交到数据库
    try:
        db.session.commit()
    except Exception as e:
        db.session.rollback()
        current_app.logger.error(e)
        return jsonify(errno=RET.DBERR, errmsg='点赞评论查询失败')

    return jsonify(errno=RET.OK, errmsg='ok')
