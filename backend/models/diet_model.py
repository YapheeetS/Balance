from mongoengine import *
import uuid
from models.food_model import Food

connect('software_db', host='localhost', port=27017)


class Diet(Document):

    diet_id = StringField(required=True)
    date = StringField(required=True)
    user_id = StringField(required=True)
    total_calories = StringField(required=True)
    recommend = StringField(required=True)
    breakfast = DictField(required=True)
    lunch = DictField(required=True)
    dinner = DictField(required=True)
    snack = DictField(required=True)

    @classmethod
    def get_diet(cls, date, user_id):
        obj = cls.objects(date=date, user_id=user_id).first()
        return obj


    @classmethod
    def create_diet(cls, date, user_id):

        uid = uuid.uuid5(uuid.NAMESPACE_DNS, user_id+date)
        uid = str(uid)
        diet_id = ''.join(uid.split('-'))

        breakfast = {'intake':'0', 'recommend': '500', 'food_list':[], 'caloris_list': []}
        lunch = {'intake': '0', 'recommend': '600', 'food_list': [], 'caloris_list': []}
        dinner = {'intake': '0', 'recommend': '400', 'food_list': [], 'caloris_list': []}
        snack = {'intake': '0', 'recommend': '200', 'food_list': [], 'caloris_list': []}


        obj = cls(diet_id=diet_id, date=date, user_id=user_id,
                  total_calories='0', recommend='1700', breakfast=breakfast, 
                  lunch=lunch, dinner=dinner, snack=snack).save()
        return obj

    @classmethod
    def add_food(cls, diet_id, name, calories, meal_type):
        
        obj = cls.objects(diet_id=diet_id).first()

        has_same_food = False
        if meal_type == 'breakfast':
            for index, food in enumerate(obj.breakfast['food_list']):
                if name == food:
                    obj.breakfast['caloris_list'][index] = calories
                    has_same_food = True
            if has_same_food == False:
                obj.breakfast['food_list'].append(name)
                obj.breakfast['caloris_list'].append(calories)
            
            total = 0
            for caloris in obj.breakfast['caloris_list']:
                total = total + float(calories)
            obj.breakfast['intake'] = str(total)

        elif meal_type == 'lunch':
            for index, food in enumerate(obj.lunch['food_list']):
                if name == food:
                    obj.lunch['caloris_list'][index] = calories
                    has_same_food = True
            if has_same_food == False:
                obj.lunch['food_list'].append(name)
                obj.lunch['caloris_list'].append(calories)

            total = 0
            for caloris in obj.lunch['caloris_list']:
                total = total + float(calories)
            obj.lunch['intake'] = str(total)
            
        elif meal_type == 'dinner':
            for index, food in enumerate(obj.dinner['food_list']):
                if name == food:
                    obj.dinner['caloris_list'][index] = calories
                    has_same_food = True
            if has_same_food == False:
                obj.dinner['food_list'].append(name)
                obj.dinner['caloris_list'].append(calories)

            total = 0
            for caloris in obj.dinner['caloris_list']:
                total = total + float(calories)
            obj.dinner['intake'] = str(total)
        else:
            for index, food in enumerate(obj.snack['food_list']):
                if name == food:
                    obj.snack['caloris_list'][index] = calories
                    has_same_food = True
            if has_same_food == False:
                obj.snack['food_list'].append(name)
                obj.snack['caloris_list'].append(calories)

            total = 0
            for caloris in obj.snack['caloris_list']:
                total = total + float(calories)
            obj.snack['intake'] = str(total)
        
        total_calories = float(obj.breakfast['intake']) + float(obj.lunch['intake']) + float(
            obj.dinner['intake']) + float(obj.snack['intake'])
        
        obj.total_calories = str(total_calories)

        obj.save()

        return obj

    
