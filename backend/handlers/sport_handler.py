import tornado.web
import json
import config
from mongoengine import *
from models.sport_model import Sport


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


class get_sport(BaseHandler):

    def post(self, *args, **kwargs):
        # date = str(self.get_argument("date"))
        # user_id = str(self.get_argument("user_id"))
        date = str(self.get_json_argument("date"))
        user_id = str(self.get_json_argument("user_id"))

        sport = Sport.get_sport(date, user_id)
        data = {'code': '200', 'user_id': sport.user_id, 'sport_id': sport.sport_id,
                'date': sport.date, 'steps': sport.steps, 'distance': sport.distance,
                'length_time': sport.length_time, 'burn_calorie': sport.burn_calorie, 'target_calories': sport.target_calories}

        self.write(json.dumps(data))


class add_activity(BaseHandler):
    
    def post(self, *args, **kwargs):
        date = str(self.get_json_argument("date"))
        user_id = str(self.get_json_argument("user_id"))
        motion_id = str(self.get_json_argument("motion_id"))
        length_time = str(self.get_json_argument("length_time"))
        burn_calorie = str(self.get_json_argument("burn_calorie"))

        sport = Sport.add_activity(user_id,date,motion_id, length_time, burn_calorie)
        data = {'code': '200', 'user_id': sport.user_id, 'sport_id': sport.sport_id,
                'date': sport.date, 'steps': sport.steps, 'distance': sport.distance,
                'length_time': sport.length_time, 'burn_calorie': sport.burn_calorie, 'target_calories': sport.target_calories}
        self.write(json.dumps(data))


class upload_steps_and_distance(BaseHandler):
    
    def post(self, *args, **kwargs):
        date = str(self.get_argument("date"))
        user_id = str(self.get_argument("user_id"))
        steps = str(self.get_argument("steps"))
        distance = str(self.get_argument("distance"))

        sport = Sport.upload_steps_and_distance(user_id, date, steps, distance)
        data = {'code': '200', 'user_id': sport.user_id, 'sport_id': sport.sport_id,
                'date': sport.date, 'steps': sport.steps, 'distance': sport.distance,
                'length_time': sport.length_time, 'burn_calorie': sport.burn_calorie, 'target_calories': sport.target_calories}
        self.write(json.dumps(data))
    
