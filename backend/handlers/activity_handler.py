import tornado.web
import json
import config
from mongoengine import *
from models.activity_model import Activity


class MissingArgumentError(Exception):
    '''自定义异常类'''

    def __init__(self, name):
        self.name = name


class BaseHandler(tornado.web.RequestHandler):
    def set_default_headers(self):
        self.add_header('Access-Control-Allow-Origin', '*')
        self.set_header("Access-Control-Allow-Headers",
                        "Content-Type,Access-Token,X-Token,x-requested-with")
        self.set_header('Access-Control-Allow-Methods',
                        "GET, POST, OPTIONS, PUT")
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


class get_activities(BaseHandler):

    def post(self, *args, **kwargs):
        data_list = Activity.get_activities()
        print(data_list)

        motion_list = []
        for activity in data_list:
            motion_list.append({'motion_id': activity.motion_id, 'motion_name': activity.motion_name, 
                                'motion_type': activity.motion_type,'motion_content': activity.motion_content, 
                                'motion_picture': activity.motion_picture, 'consume_calorie': activity.consume_calorie})

        data = {'code': '200', 'motion_list': motion_list}
        self.write(json.dumps(data))

