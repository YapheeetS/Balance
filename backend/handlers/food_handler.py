import tornado.web
import json
import config
from mongoengine import *
from models.food_model import Food


class MissingArgumentError(Exception):
    '''自定义异常类'''
    def __init__(self, name):
        self.name = name

class BaseHandler(tornado.web.RequestHandler):
    def set_default_headers(self):
        self.add_header('Access-Control-Allow-Origin', '*')
        self.set_header("Access-Control-Allow-Headers", "Content-Type,Access-Token,X-Token,x-requested-with")
        self.set_header('Access-Control-Allow-Methods', "GET, POST, OPTIONS, PUT")
        self.set_header('Access-Control-Allow-Credentials', '*')
        self.set_header('Access-Control-Expose-Headers', '*')

    def get_json_argument(self, name, default=None):
        args = json.loads(self.request.body)
        # name = to_unicode(name)
        if name in args:
            return args[name]
        elif default is not None:
            return default
        else:
            raise MissingArgumentError(name)

class get_common_food(BaseHandler):
    
    def post(self, *args, **kwargs):
        data_list = Food.get_common_food()
        print(data_list)

        food_list = []
        for food in data_list:
            food_list.append({'id': food.food_id, 'name': food.name, 'hot': food.hot, 'icon': food.icon, 'company': food.company, 'spec': food.spec})

        data = {'code': '200','food_list': food_list}
        self.write(json.dumps(data))


class search_food_with_name(BaseHandler):
    
    def post(self, *args, **kwargs):
        name = str(self.get_json_argument("name"))
        # name = str(self.get_argument("name"))
        food = Food.search_food(name)
        food_list = []
        food_list.append({'id': food.food_id, 'name': food.name, 'hot': food.hot,
                          'icon': food.icon, 'company': food.company, 'spec': food.spec})

        data = {'code': '200', 'food_list': food_list}
        self.write(json.dumps(data))
