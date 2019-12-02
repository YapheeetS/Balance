from mongoengine import *

connect('software_db', host='localhost', port=27017)


class Activity(Document):

    motion_id = StringField(required=True)
    motion_name = StringField(required=True)
    motion_type = StringField(required=True)
    motion_content = StringField(required=True)
    motion_picture = StringField(required=True)
    consume_calorie = StringField(required=True)

    @classmethod
    def get_activities(cls):
        """Get agents id according to task id for frontend display
        """
        objs = cls.objects
        return objs

    @classmethod
    def get_activity_with_id(cls, motion_id):
        """Get agents id according to task id for frontend display
        """
        obj = cls.objects(motion_id=motion_id).first()
        return obj

# data = {"code": "200",
#         "activity_list": [
#             {"motion_id": "1",
#              "motion_name": "Walking",
#              "motion_type": "distance",
#              "motion_content": "Walking 30min\\nConsum 121Cal",
#              "motion_picture": "http://www.xinyuekang.com.cn/data/upload/motion/motion_img/buxing.png",
#              "consume_calorie": "4"
#             },
#             {"motion_id": "2",
#              "motion_name": "Running",
#              "motion_type": "distance",
#              "motion_content": "Running 30min\\nConsume 279Cal",
#              "motion_picture": "http://www.xinyuekang.com.cn/data/upload/motion/motion_img/paobu.png",
#              "consume_calorie": "9.3"
#             },
#             {"motion_id": "3",
#              "motion_name": "Cycling",
#              "motion_type": "distance",
#              "motion_content": "Cycling 30min\\nConsum 140Cal",
#              "motion_picture": "http://www.xinyuekang.com.cn/data/upload/motion/motion_img/zixingche.png",
#              "consume_calorie": "4.7"
#             },
#             {"motion_id": "4",
#              "motion_name": "Swimming",
#              "motion_type": "time",
#              "motion_content": "Swimming 30min\\nConsume 279Cal",
#              "motion_picture": "http://www.xinyuekang.com.cn/data/upload/motion/motion_img/youyong.png",
#              "consume_calorie": "9.3"
#             },
#             {"motion_id": "5",
#              "motion_name": "Basketball",
#              "motion_type": "time",
#              "motion_content": "Basketball 30min\\nConsume 210Cal",
#              "motion_picture": "http://www.xinyuekang.com.cn/data/upload/motion/motion_img/lanqiu.png",
#              "consume_calorie": "7"
#              }
#             ]
# }

# for e in data['activity_list']:
#     Activity(motion_id=e['motion_id'], motion_name=e['motion_name'], motion_type=e['motion_type'],
#          motion_content=e['motion_content'], motion_picture=e['motion_picture'], consume_calorie=e['consume_calorie']).save()
