from flask import Blueprint

search_blu = Blueprint('search', __name__)

from . import views
