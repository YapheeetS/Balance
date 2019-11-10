import tornado.web
import json
import config
from mongoengine import *
from models.diet_model import Diet


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


class get_diet(BaseHandler):

    def post(self, *args, **kwargs):

        date = str(self.get_json_argument("date"))
        user_id = str(self.get_json_argument("user_id"))

        # date = str(self.get_argument("date"))
        # user_id = str(self.get_argument("user_id"))

        diet = Diet.get_diet(date, user_id)
        
        if diet == None:
            diet = Diet.create_diet(date, user_id)

        meals = []
        name = ''
        for food in diet.breakfast['food_list']:
            name = name + ' ' + food
        meals.append(
            {'intake': diet.breakfast['intake'], 'recommend': diet.breakfast['recommend'], 'name': name})
        
        name = ''
        for food in diet.lunch['food_list']:
            name = name + ' ' + food
        meals.append(
            {'intake': diet.lunch['intake'], 'recommend': diet.lunch['recommend'], 'name': name})

        name = ''
        for food in diet.dinner['food_list']:
            name = name + ' ' + food
        meals.append(
            {'intake': diet.dinner['intake'], 'recommend': diet.dinner['recommend'], 'name': name})

        name = ''
        for food in diet.snack['food_list']:
            name = name + ' ' + food
        meals.append(
            {'intake': diet.snack['intake'], 'recommend': diet.snack['recommend'], 'name': name})

        data = {'code': '200', 'user_id': diet.user_id, 'diet_id': diet.diet_id,
                'date': diet.date, 'total_calories': diet.total_calories, 'recommend': diet.recommend, 
                'meals': meals}

        self.write(json.dumps(data))


class add_food(BaseHandler):

    def post(self, *args, **kwargs):

        diet_id = str(self.get_json_argument("diet_id"))
        meal_type = str(self.get_json_argument("meal_type"))
        name = str(self.get_json_argument("name"))
        calories = str(self.get_json_argument("calories"))

        # diet_id = str(self.get_argument("diet_id"))
        # meal_type = str(self.get_argument("meal_type"))
        # name = str(self.get_argument("name"))
        # calories = str(self.get_argument("calories"))

        diet = Diet.add_food(diet_id, name, calories, meal_type)

        data = {'code': '200', 'user_id': diet.user_id, 'diet_id': diet.diet_id,
                'date': diet.date, 'total_calories': diet.total_calories, 'recommend': diet.recommend,
                'breakfast': diet.breakfast, 'lunch': diet.lunch, 'dinner': diet.dinner, 'snack': diet.snack}

        self.write(json.dumps(data))

