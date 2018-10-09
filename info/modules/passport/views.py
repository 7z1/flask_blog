from flask import jsonify, session
from info.utils.response_code import RET
from . import passport_blu


@passport_blu.route('/login_out')
def login_out():
    """
    清除session中的对应登录之后保存的信息
    :return:
    """
    session.pop('user_id')
    session.pop('nick_name')
    session.pop('mobile')
    session.pop('is_admin', None)
    return jsonify(errno=RET.OK, errmsg='成功退出')
