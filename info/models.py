from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash

from info import constants
from . import db


class BaseModel(object):
    """模型基类，为每个模型补充创建时间与更新时间"""
    create_time = db.Column(db.DateTime, default=datetime.now)  # 记录的创建时间
    update_time = db.Column(db.DateTime, default=datetime.now, onupdate=datetime.now)  # 记录的更新时间


class AdminUser(BaseModel, db.Model):
    """用户"""
    __tablename__ = "info_adminuser"
    id = db.Column(db.Integer, primary_key=True)  # 编号
    card_name = db.Column(db.String(64), nullable=False)  # 名片名字
    card_avatar = db.Column(db.String(64), nullable=False)  # 名片头像
    card_about = db.Column(db.String(64), nullable=False)  # 名片介绍
    card_job = db.Column(db.String(64), nullable=False)  # 名片职位
    title = db.Column(db.String(64), nullable=False)  # 网站标题
    description = db.Column(db.String(256), nullable=False)  # 描述信息
    keywords = db.Column(db.String(256), nullable=False)  # SEO关键词
    email = db.Column(db.String(64), nullable=False)  # 邮箱
    qq = db.Column(db.String(32), nullable=False)  # qq
    wxid = db.Column(db.String(64), nullable=False)  # 邮箱
    wxcode = db.Column(db.String(64), nullable=False)  # 微信二维码账号
    butoom_title = db.Column(db.String(64), nullable=False)  # 底部标题
    beian = db.Column(db.String(64), nullable=False)  # 底部备案
    logo_name = db.Column(db.String(64), nullable=False)  # logo名字
    logo_image = db.Column(db.String(64), nullable=False)  # logo图片链接
    about_me = db.Column(db.Text, nullable=False)  # 关于我
    tags = db.Column(db.String(256), nullable=False)  # 标签云词

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "keywords": self.keywords,
            "email": self.email,
            "qq": self.qq,
            "tags": self.tags,
            "wxid": self.wxid,
            "wxcode": self.wxcode,
            "butoom_title": self.butoom_title,
            "beian": self.beian,
            "about_me": self.about_me,
            "card_name": self.card_name,
            "card_job": self.card_job,
            "card_about": self.card_about,
            "card_avatar": self.card_avatar,
            "update_time": self.update_time.strftime("%Y-%m-%d %H:%M:%S"),
            "logo_name": self.logo_name,
            "logo_image": self.logo_image,
        }
        return resp_dict

    def to_index_dict(self):
        resp_dict = {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "keywords": self.keywords,
            "card_avatar": self.card_avatar,
            "email": self.email,
            "qq": self.qq,
            "card_name": self.card_name,
            "card_job": self.card_job,
            "card_about": self.card_about,
            "tags": self.tags.split(','),
            "about_me": self.about_me,
            "wxid": self.wxid,
            "wxcode": self.wxcode,
            "butoom_title": self.butoom_title,
            "beian": self.beian,
            "logo_name": self.logo_name,
            "logo_image": self.logo_image,
        }
        return resp_dict


class User(BaseModel, db.Model):
    """用户"""
    __tablename__ = "info_user"

    id = db.Column(db.Integer, primary_key=True)  # 用户编号
    nick_name = db.Column(db.String(32), unique=True, nullable=False)  # 用户昵称
    password_hash = db.Column(db.String(128), nullable=False)  # 加密的密码
    mobile = db.Column(db.String(11), unique=True, nullable=False)  # 手机号
    avatar_url = db.Column(db.String(256))  # 用户头像路径
    last_login = db.Column(db.DateTime, default=datetime.now)  # 最后一次登录时间
    is_admin = db.Column(db.Boolean, default=False)
    signature = db.Column(db.String(512))  # 用户签名
    gender = db.Column(  # 性别
        db.Enum(
            "MAN",  # 男
            "WOMAN"  # 女
        ),
        default="MAN")

    @property
    def password(self):
        raise AttributeError("当前属性不可读")

    @password.setter
    def password(self, value):
        self.password_hash = generate_password_hash(value)

    def check_passowrd(self, password):
        return check_password_hash(self.password_hash, password)

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "nick_name": self.nick_name,
            "avatar_url": self.avatar_url,  # constants.QINIU_DOMIN_PREFIX + self.avatar_url if self.avatar_url else "",
            "mobile": self.mobile,
            "gender": self.gender if self.gender else "MAN",
            "signature": self.signature if self.signature else "",
        }
        return resp_dict

    def to_admin_dict(self):
        resp_dict = {
            "id": self.id,
            "nick_name": self.nick_name,
            "mobile": self.mobile,
            "register": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            "last_login": self.last_login.strftime("%Y-%m-%d %H:%M:%S"),
        }
        return resp_dict


class NewsAction(BaseModel, db.Model):
    """文章状态：是否首页推荐或特别推荐，通过第三张表来快速查询被推荐的文章"""
    __tablename__ = "info_news_action"
    id = db.Column(db.Integer, primary_key=True)
    news_id = db.Column(db.Integer, db.ForeignKey("info_news.id"))  # 外键关联文章id
    is_banner = db.Column(db.Boolean, default=False)  # 是否首页banner推荐
    is_top = db.Column(db.Boolean, default=False)  # 是否top推荐
    is_tuijian = db.Column(db.Boolean, default=False)  # 是否特别推荐
    # 查询所有内容
    news_action = db.relationship('News', backref=db.backref('action', lazy='dynamic'))


class News(BaseModel, db.Model):
    """文章"""
    __tablename__ = "info_news"

    id = db.Column(db.Integer, primary_key=True)  # 文章编号
    title = db.Column(db.String(64), nullable=False)  # 文章标题
    source = db.Column(db.String(64), default="棋子。", nullable=False)  # 文章来源
    digest = db.Column(db.String(512), nullable=False)  # 文章摘要
    content = db.Column(db.Text, nullable=False)  # 文章内容
    clicks = db.Column(db.Integer, default=0)  # 浏览量
    index_image_url = db.Column(db.String(256))  # 文章列表图片路径
    category_id = db.Column(db.Integer, db.ForeignKey("info_category.id"))
    status = db.Column(db.Integer, default=0)  # 当前文章状态 如果为0代展示，1为逻辑删除
    like_count = db.Column(db.Integer, default=0)  # 文章点赞数
    # 当前新闻的所有评论
    comments = db.relationship("Comment", lazy="dynamic", cascade='all, delete-orphan', passive_deletes=True)

    __table_args__ = {
        "mysql_charset": "utf8mb4"
    }

    def to_review_dict(self):
        resp_dict = {
            "id": self.id,
            "title": self.title,
            "create_time": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            "status": self.status,
            "reason": self.reason if self.reason else ""
        }
        return resp_dict

    def to_basic_dict(self):
        resp_dict = {
            "id": self.id,
            "title": self.title,
            "source": self.source,
            "digest": self.digest,
            "create_time": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            "create_date": self.create_time.strftime("%Y-%m-%d"),
            "index_image_url": self.index_image_url,
            "clicks": self.clicks,
        }
        return resp_dict

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "title": self.title,
            "source": self.source if self.source else "棋子。",
            "digest": self.digest,
            "create_time": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            "create_date": self.create_time.strftime("%Y-%m-%d"),
            "content": self.content,
            "comments_count": self.comments.count(),
            "clicks": self.clicks,
            "category": self.category.to_dict(),
            "index_image_url": self.index_image_url,
            "like_count": self.like_count if self.like_count else 0,
            # "author": self.user.to_dict() if self.user else None,
        }
        return resp_dict


class Comment(BaseModel, db.Model):
    """评论"""
    __tablename__ = "info_comment"

    id = db.Column(db.Integer, primary_key=True)  # 评论编号
    news_id = db.Column(db.Integer, db.ForeignKey("info_news.id", ondelete='CASCADE'), nullable=False)  # 新闻id
    content = db.Column(db.Text, nullable=False)  # 评论内容
    # 自关联级联删除直接在外键设置里面增加ondelete='CASCADE'
    parent_id = db.Column(db.Integer, db.ForeignKey("info_comment.id", ondelete='CASCADE'))  # 父评论id
    parent = db.relationship("Comment", remote_side=[id])  # 自关联
    like_count = db.Column(db.Integer, default=0)  # 点赞条数
    # 设置数据库表编码方式为utf8mb4
    __table_args__ = {
        "mysql_charset": "utf8mb4"
    }

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "create_time": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            # 过滤尖括号防止xss
            # "content": self.content,
            "content": self.content.replace('<', '(') if '<' in self.content else self.content,
            "parent": self.parent.to_dict() if self.parent else None,
            "news_id": self.news_id,
            "like_count": self.like_count
        }
        return resp_dict


class Category(BaseModel, db.Model):
    """分类"""
    __tablename__ = "info_category"

    id = db.Column(db.Integer, primary_key=True)  # 分类编号
    name = db.Column(db.String(64), nullable=False)  # 分类名
    news_list = db.relationship('News', backref='category', lazy='dynamic')

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "name": self.name
        }
        return resp_dict


class Link(BaseModel, db.Model):
    """友情链接"""
    __tablename__ = "info_link"

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(32), nullable=True)
    url = db.Column(db.String(32), nullable=True)
    # 设置数据库表编码方式为utf8mb4
    __table_args__ = {
        "mysql_charset": "utf8mb4"
    }

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "name": self.name,
            "url": self.url,
        }
        return resp_dict


class Gbook(BaseModel, db.Model):
    """评论"""
    __tablename__ = "info_gbook"

    id = db.Column(db.Integer, primary_key=True)  # 留言编号
    ip = db.Column(db.String(32), nullable=True)  # ip
    replyName = db.Column(db.String(16), default='热心网民', nullable=True)  # 评论昵称
    beReplyName = db.Column(db.String(16), nullable=True)  # 被回复者昵称
    email = db.Column(db.String(32), nullable=True)  # 邮箱
    browser = db.Column(db.String(16), nullable=True)  # 浏览器
    os_name = db.Column(db.String(16), nullable=True)  # 操作系统
    content = db.Column(db.Text, nullable=False)  # 留言内容
    son_id = db.Column(db.Integer, db.ForeignKey("info_gbook.id", ondelete='CASCADE'))  # 自评论id
    son = db.relationship("Gbook", remote_side=[id])  # 自关联

    # 设置数据库表编码方式为utf8mb4
    __table_args__ = {
        "mysql_charset": "utf8mb4"
    }

    def to_dict(self):
        resp_dict = {
            "id": self.id,
            "ip": self.ip if self.ip else "127.0.0.1",
            "img": "http://blog.xiaosankexing.com/FkYTTlB4LR8g0RT2tq_xcpk5aRIy",
            "browser": self.browser if self.browser else "",
            "os_name": self.os_name if self.os_name else "",
            "time": self.create_time.strftime("%Y-%m-%d %H:%M:%S"),
            "replyName": self.replyName if self.replyName else "热心网民",
            # "content": self.content,
            "content": self.content.replace('<', '(') if '<' in self.content else self.content,
            "replyBody": [self.son.to_dict()] if self.son else "",
            "beReplyName": self.beReplyName if self.beReplyName else "热心网民",
            "create_time": self.create_time,
        }
        return resp_dict

