import functools
from flask import session, g
import requests


def do_index_class(index):
    if index == 0:
        return "first"
    elif index == 1:
        return "second"
    elif index == 2:
        return "third"
    else:
        return ""


def user_login_data(f):
    @functools.wraps(f)
    def wrapper(*args, **kwargs):
        # 获取到当前登录用户的id
        user_id = session.get("user_id")
        # 通过id获取用户信息
        user = None
        if user_id:
            from info.models import User
            user = User.query.get(user_id)

        g.user = user
        return f(*args, **kwargs)

    return wrapper


def get_ua(ua):
    """
    获取ua头包含的信息
    :param ua: 
    :return: 
    """
    url = 'http://www.useragentstring.com/?uas=%s&getJSON=all' % ua
    resp = requests.get(url).json()
    browser = resp['agent_name']
    os_name = resp['os_name']
    ua_data = {
        'browser': browser,
        'os_name': os_name
    }
    return ua_data
