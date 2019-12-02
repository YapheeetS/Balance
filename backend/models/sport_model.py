from mongoengine import *
import uuid
from models.activity_model import Activity

connect('software_db', host='localhost', port=27017)


class Sport(Document):

    sport_id = StringField(required=True)
    date = StringField(required=True)
    user_id = StringField(required=True)
    target_calories = StringField(required=True)
    length_time = StringField(required=True)
    burn_calorie = StringField(required=True)
    steps = StringField(required=True)
    distance = StringField(required=True)
    activities = ListField()

    @classmethod
    def get_sport(cls, date, user_id):
        obj = cls.objects(date=date, user_id=user_id).first()
        if obj == None:
            obj = Sport.create_sport(date=date, user_id=user_id)
        return obj

    @classmethod
    def create_sport(cls, date, user_id):
        uid = uuid.uuid5(uuid.NAMESPACE_DNS, user_id+date)
        uid = str(uid)
        sport_id = ''.join(uid.split('-'))
        activities = []
        obj = cls(sport_id=sport_id, date=date, user_id=user_id,
                  steps='0', distance='0', length_time='0', burn_calorie='0',
                  target_calories='500', activities=activities).save()
        return obj

    @classmethod
    def add_activity(cls, user_id, date, motion_id, length_time, burn_calorie):

        obj = cls.objects(date=date, user_id=user_id).first()
        if obj == None:
            obj = Sport.create_sport(date=date, user_id=user_id)
        
        a = Activity.get_activity_with_id(motion_id)

        has_same_activity = False
        for index, activity in enumerate(obj.activities):
            if activity["motion_id"] == motion_id:
                obj.activities[index]["consume"] = str(float(
                    obj.activities[index]["consume"]) + float(burn_calorie))
                has_same_activity = True

        if has_same_activity == False:
            obj.activities.append(
                {"motion_id": motion_id, "motion_name": a.motion_name, "consume": burn_calorie})

        obj.length_time = str(float(obj.length_time) + float(length_time))
        obj.burn_calorie = str(float(obj.burn_calorie) + float(burn_calorie))
        obj.save()
        return obj

    @classmethod
    def upload_steps_and_distance(cls, user_id, date, steps, distance):
        obj = cls.objects(date=date, user_id=user_id).first()
        if obj == None:
            obj = Sport.create_sport(date=date, user_id=user_id)
        obj.steps = steps
        obj.distance = distance
        obj.save()
        return obj


