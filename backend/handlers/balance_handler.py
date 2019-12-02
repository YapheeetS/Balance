import tornado.web
import json
import config
from mongoengine import *
from models.diet_model import Diet
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


class get_balance_data(BaseHandler):

    def post(self, *args, **kwargs):
        date = str(self.get_json_argument("date"))
        user_id = str(self.get_json_argument("user_id"))

        diet = Diet.get_diet(date, user_id)
        if diet == None:
            diet = Diet.create_diet(date, user_id)
        diet_list = []
        diet_list.append(["Breakfast", diet.breakfast['intake']])
        diet_list.append(["Lunch", diet.lunch['intake']])
        diet_list.append(["Dinner", diet.dinner['intake']])
        diet_list.append(["Snacks", diet.snack['intake']])
        
        sport = Sport.get_sport(date, user_id)
        sport_list = []
        for index, activity in enumerate(sport.activities):
            sport_list.append([activity["motion_name"], activity["consume"]])

        consume = str(float(diet.recommend) + float(sport.burn_calorie))
        data = {'code': '200', 'consume': consume,
                'intake': diet.total_calories, 'data_list': [sport_list, diet_list]}
        self.write(json.dumps(data))
        


