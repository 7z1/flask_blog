from flask import Blueprint

passport_blu = Blueprint('passprot', __name__, url_prefix='/passport')

from . import views
