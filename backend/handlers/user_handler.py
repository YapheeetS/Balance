import tornado.web
import json
import config
from models.user_model import User
from mongoengine import *
import uuid

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
    
    def get_json_argument(self, name, default = None):
        args = json.loads(self.request.body)
        # name = to_unicode(name)
        if name in args:
            return args[name]
        elif default is not None:
            return default
        else:
            raise MissingArgumentError(name)
    

class create_user(BaseHandler):
    
    def post(self, *args, **kwargs):
        # receive
        account = str(self.get_json_argument("account"))
        password = str(self.get_json_argument("password"))
        gender = str(self.get_json_argument("gender"))
        birthday = str(self.get_json_argument("birthday"))
        height = str(self.get_json_argument("height"))
        weight = str(self.get_json_argument("weight"))
        
        uid = uuid.uuid5(uuid.NAMESPACE_DNS, account)
        uid = str(uid)
        user_id = ''.join(uid.split('-'))
        

        user = User.create_user(user_id, account, password, gender, birthday, height, weight)

        if user == None:
            data = {'code': '400','message': 'Account already exists',}
            self.write(json.dumps(data))
        else:
            data = {'code': '200',
            'message': 'Success',
            'user_info': {'user_id': user_id, 'account': account, 'password': password, 
            'gender': gender, 'birthday': birthday, 'height': height, 'weight': weight}}

            self.write(json.dumps(data))
        # self.write(json.dumps({'code': '200'}))


class login(BaseHandler):

    def post(self, *args, **kwargs):

        account = str(self.get_json_argument("account"))
        password = str(self.get_json_argument("password"))

        user = User.get_user_with_account(account)

        if user != None:
            if user.password == password:
                data = {'code': '200',
                'message': 'Success',
                'user_info': {'user_id': user.user_id, 'account': user.account, 'password': user.password, 
                'gender': user.gender, 'birthday': user.birthday, 'height': user.height, 'weight': user.weight}}
                self.write(json.dumps(data))
            else:
                data = {'code': '300',
                'message': 'wrong password'}
                self.write(json.dumps(data))
        else:
            data = {'code': '300',
            'message': 'unexisted account'}
            self.write(json.dumps(data))
        

class get_user_info(BaseHandler):

    def post(self, *args, **kwargs):
        # receive
        user_id = str(self.get_json_argument("user_id"))
        user = User.get_user_with_id(user_id)

        data = {'code': '200',
            'message': 'Success',
            'user_info': {'user_id': user.user_id, 'account': user.account, 'password': user.password, 
            'gender': user.gender, 'birthday': user.birthday, 'height': user.height, 'weight': user.weight}}
        
        self.write(json.dumps(data))




