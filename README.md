### 创建数据库，charset=utf8mb4，参考下面的评论模型设置



博客演示站点：www.7z1.xyz

如出现未备案，请直接访问http://119.23.230.6/



##### 文章点赞

~~~python
 登陆和未登陆：
    未登陆：记录当前cookie，一个cookie只可点赞一次
    登陆：每个用户只可点赞一次，再次点击取消点赞
~~~



##### 评论功能

~~~python
 登陆和未登陆：
    未登陆：
    登陆：
~~~



### 统一为未登陆，整站为博客网站，不设用户注册功能，没有必要，所以所有评论和回复皆为匿名评论



##### 个人信息配置，写数据库模型文件，初始模型，最终已models.py为准

~~~python
title			网站标题
description		描述信息
keywords		seo关键词
email			邮箱
wxid			微信公众号
wxcode			微信二维码
butoom_title	底部标题
beian			备案号
about			关于我
tags			云词标签	pointer-events在页面设置穿透属性，这样鼠标事件只会在设置auto的标签上生效
"title": self.title,
"description": self.description,
"keywords": self.keywords,
"email": self.email,
"wxid": self.wxid,
"wxcode": self.wxcode,
"butoom_title": self.butoom_title,
"beian": self.beian,
"about_me": self.about_me,
"card_name": self.card_name,
"card_job": self.card_job,
"card_about": self.card_about,
"card_avatar": self.card_avatar,
~~~



##### 设置文章是否首页推荐  (推荐 and 特别推荐 and 首页推荐)

~~~python
编写推荐文章模型类，外键关联文章id   已完成
后台编写视图，点击添加推荐文章    已完成
~~~



##### 回收站

~~~python
在文章管理页面删除文章为逻辑删除		将status状态更改为1
status状态为1的文章将不在后台和首页显示
可以前往回收站页面，选择将文章彻底删除或者恢复
~~~



##### 友情链接管理



##### 文章采集

~~~python
在后台编写文章采集视图
接收参数	
	搜索关键词
	采集回来的文章分类
    文章来源	--- 例如：简书、CSDN

简书文章搜索接口	https://www.jianshu.com/search/do?q=python&type=note&page=1&order_by=default
    order_by=top			热门
    order_by=default		默认
    order_by=published_at	最新
    q=python				搜索关键词
    page=1					页数
    
    返回数据
    
未完成
~~~



##### 评论模型

~~~python
var arr = [
		{id:1,img:"../static/images/img.jpg",replyName:"帅大叔",beReplyName:"",content:"同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。",time:"2017-10-17 11:42:53",address:"深圳",osname:"",browse:"谷歌",replyBody:[]},
		{id:2,img:"../static/images/img.jpg",replyName:"匿名",beReplyName:"",content:"到菜市场买菜，看到一个孩子在看摊，我问：“一只鸡多少钱？” 那孩子回答：“23。” 我又问：“两只鸡多少钱？” 孩子愣了一下，一时间没算过来，急中生智大吼一声：“一次只能买一只！”",time:"2017-10-17 11:42:53",address:"深圳",osname:"",browse:"谷歌",replyBody:[{id:3,img:"",replyName:"帅大叔",beReplyName:"匿名",content:"来啊，我们一起吃鸡",time:"2017-10-17 11:42:53",address:"",osname:"",browse:"谷歌"}]},
		{id:3,img:"../static/images/img.jpg",replyName:"帅大叔",beReplyName:"",content:"同学聚会，看到当年追我的屌丝开着宝马车带着他老婆来了，他老婆是我隔壁宿舍的同班同学，心里后悔极了。",time:"2017-10-17 11:42:53",address:"深圳",osname:"win10",browse:"谷歌",replyBody:[]},
        {id:4,img:"../static/images/img.jpg",replyName:"匿名",beReplyName:"",content:"1”",time:"2017-10-17 11:42:53",address:"深圳",osname:"",browse:"谷歌",replyBody:[{id:3,img:"",replyName:"帅大叔",beReplyName:"匿名111",content:"2",time:"2017-10-17 11:42:53",address:"",osname:"",browse:"谷歌"},{id:3,img:"",replyName:"帅大叔333",beReplyName:"匿名11122",content:"233",time:"2017-10-17 11:42:53",address:"",osname:"",browse:"谷歌"}]},
		];

id				记录每条评论的标记
img				头像地址											 统一设置默认值
replyName		评论人昵称											如果为null默认是匿名用户
beReplyName		被回复的评论人昵称	只有二级评论才有该选项				同上
content			评论内容
time			创建时间
address			ip地址
osname			操作系统
browse			浏览器
replyBody		子评论


列表中每一个字典都是一条评论，如果有评论回复改评论，则replyBody又是一个列表，
列表里面嵌套对应的回复评论，有多少条评论，replyBody列表中就有多少个字典

首页留言页面不设回复评论功能
管理后台设置评论管理，在后台回复评论
父评论需对应子评论id
子评论beReplyName需对应父评论replyName   缺一不可

http://www.useragentstring.com/?uas={{ua}}&getJSON=all
传入ua字符串可获得浏览器及系统信息json字符串


设置评论和留言支持emoji表情插入，防止访客留言时输入emoji表情导致报错

设置字段支持utf8mb4
ALTER table info_gbook modify email varchar(32) character set utf8mb4 collate utf8mb4_unicode_ci;

ALTER table info_gbook modify content text character set utf8mb4 collate utf8mb4_unicode_ci;

设置表支持utf8mb4
ALTER TABLE info_gbook CHARSET=utf8mb4;
设置库支持utf8mb4
SET NAMES utf8mb4;
查看数据库编码类型
show variables like 'character%';

在SQL创建数据库的时候设置CREATE DATABASE myblog CHARSET=UTF8mb4;
只有这样mysql://user:pass@localhost /db?charset=utf8mb4才能生效

设置数据库表编码方式为utf8mb4
class User(Base):    
    __tablename__ = 'tb_user’		
    id = Column(Integer,primary_key = True,autoincrement=True)    
    name = Column(String(250),nullable=False,unique = True,comment=u"姓名")    
    __table_args__ = {        
        "mysql_charset" : "utf8mb4"
    }

   
过滤尖括号防止xss

获取ip问题 
在部署的时候，因为 nginx 配置文件设置了 
proxy_set_header Host $host:80; 
proxy_set_header X-Real-IP $remote_addr; 
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 

因此通过 
from flask import request 
ip=request.headers['X-Forwarded-For'] 
就可以获取真实 ip


待补充
	根据ip限制每个ip当天只能留言10条，防止使用爬虫或者第三方工具恶意发布评论，导致数据库冗余
    
    数据备份/数据恢复
    
    添加前端显示emoji表情功能，后台文章添加emoji表情			已完成
    
    添加celery异步发起浏览器信息获取请求	暂时无法实现，因为需要获取到浏览器信息才能写入数据库
    
    文章评论管理
~~~

