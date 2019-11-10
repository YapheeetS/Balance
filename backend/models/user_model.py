from mongoengine import *
from models.agent_model import Agent


connect('software_db', host='localhost', port=27017)

class User(Document):

    user_id = StringField(required=True)
    account = StringField(required=True)
    password = StringField(required=True)
    gender = StringField(required=True)
    birthday = StringField(required=True)
    height = StringField(required=True)
    weight = StringField(required=True)


    @classmethod
    def get_user_with_id(cls, user_id):

        obj = cls.objects(user_id=user_id).first()
        return obj

    @classmethod
    def get_user_with_account(cls, account):

        obj = cls.objects(account=account).first()
        return obj

    @classmethod
    def create_user(cls, user_id, account, password, gender, birthday, height, weight):

        obj = cls.objects(account=account).first()
        
        if obj != None:
            return None
        else:
            obj = cls(user_id=user_id, account=account, password=password, gender=gender, birthday=birthday, height=height, weight=weight).save()
        return obj

