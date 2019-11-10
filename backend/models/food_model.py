from mongoengine import *

connect('software_db', host='localhost', port=27017)


class Food(Document):

    food_id = StringField(required=True)
    name = StringField(required=True)
    hot = StringField(required=True)
    icon = StringField(required=True)
    company = ListField(required=True)
    spec = ListField(required=True)

    @classmethod
    def get_common_food(cls):
        """Get agents id according to task id for frontend display
        """
        objs = cls.objects
        return objs

    @classmethod
    def search_food(cls, name):
        """Get agents id according to task id for frontend display
        """
        obj = cls.objects(name=name).first()
        return obj

    @classmethod
    def get_food_with_id(cls, food_id):
        """Get agents id according to task id for frontend display
        """
        obj = cls.objects(food_id=food_id).first()
        return obj



# data = {"code": "200",
#         "food_list": [
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/a298b57791c0496f8e1f0688cb62ed7d.jpg",
#                 "name": "Rice",
#                 "hot": "116cal / 100g",
#                 "id": "97937206829056",
#                 "company": [
#                     "g",
#                     "Bowl (small bowl)",
#                     "Box",
#                     "Spoon",
#                     "Bowl"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "116"
#                     },
#                     {
#                         "kg": "150.0",
#                         "hot": "174",
#                         "spec": "1Bowl (small bowl)"
#                     },
#                     {
#                         "kg": "280.0",
#                         "hot": "325",
#                         "spec": "1Box"
#                     },
#                     {
#                         "kg": "40.0",
#                         "hot": "46",
#                         "spec": "1Spoon"
#                     },
#                     {
#                         "kg": "200.0",
#                         "hot": "232",
#                         "spec": "1Bowl"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/35162ec1387340c0b7e704c6961e03a9.jpg",
#                 "name": "Corn (fresh)",
#                 "hot": "112cal / 100g",
#                 "id": "97937206829058",
#                 "company": [
#                     "g",
#                     "number"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "112"
#                     },
#                     {
#                         "kg": "132.0",
#                         "hot": "148",
#                         "spec": "1"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/mid_photo_20152415513316.jpg",
#                 "name": "Noodles (boiled)",
#                 "hot": "110cal / 100g",
#                 "id": "97937206829070",
#                 "company": [
#                     "g",
#                     "Bowl"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "110"
#                     },
#                     {
#                         "kg": "350.0",
#                         "hot": "385",
#                         "spec": "1Bowl"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/59e4b55ed0354e90b40fb368b2eb80eb.jpg",
#                 "name": "Whole wheat bread",
#                 "hot": "246cal / 100g",
#                 "id": "97937206829094",
#                 "company": [
#                     "g",
#                     "Slice"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "246"
#                     },
#                     {
#                         "kg": "36.0",
#                         "hot": "89",
#                         "spec": "1Slice"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/57918ed868f940228750daaa2cb717cf.jpg",
#                 "name": "Oatmeal",
#                 "hot": "368cal / 100g",
#                 "id": "97937206829117",
#                 "company": [
#                     "g",
#                     "Spoon"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "368"
#                     },
#                     {
#                         "kg": "12.0",
#                         "hot": "44",
#                         "spec": "1Spoon"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/d949f82536e04b8a973cd0647aca27f4.jpg",
#                 "name": "Poached egg (boiled)",
#                 "hot": "164cal / 100g",
#                 "id": "97937361844335",
#                 "company": [
#                     "g",
#                     "number"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "164"
#                     },
#                     {
#                         "kg": "50.0",
#                         "hot": "82",
#                         "spec": "1"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/b83862bacebf46b69f399fa9140cd021.jpg",
#                 "name": "Yogurt",
#                 "hot": "72cal / 100ml",
#                 "id": "97937415671808",
#                 "company": [
#                     "ml"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "72"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/d4eb153c4cf248a0895baa7b4d0bb9df.jpg",
#                 "name": "Apple",
#                 "hot": "54cal / 100g",
#                 "id": "97937415671938",
#                 "company": [
#                     "g"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "54"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/8f92f8c50c9f44eab94b6a71b5c10e8e.jpg",
#                 "name": "Banana",
#                 "hot": "93cal / 100g",
#                 "id": "97937415671939",
#                 "company": [
#                     "g"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "93"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/cd937b66547f4f3fae52e6e66fcd2c71.jpg",
#                 "name": "Cabbage",
#                 "hot": "24cal / 100g",
#                 "id": "97937415671986",
#                 "company": [
#                     "g",
#                     "number"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "24"
#                     },
#                     {
#                         "kg": "404.0",
#                         "hot": "97",
#                         "spec": "1"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/ff5f59e8e1e748af99b0df68322bb608.jpg",
#                 "name": "Broccoli",
#                 "hot": "36cal / 100g",
#                 "id": "97937415671994",
#                 "company": [
#                     "g",
#                     "number"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "36"
#                     },
#                     {
#                         "kg": "291.0",
#                         "hot": "105",
#                         "spec": "1"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/777c7298e74340178897c676ee9c2297.jpg",
#                 "name": "Cashew",
#                 "hot": "559cal / 100g",
#                 "id": "97937415672123",
#                 "company": [
#                     "g"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "559"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/mid_photo_url_1584d94b60971ecf26cc9beecfc87d95.jpg",
#                 "name": "Purple potato",
#                 "hot": "70cal / 100g",
#                 "id": "97937415672391",
#                 "company": [
#                     "g",
#                     "number"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "70"
#                     },
#                     {
#                         "kg": "200.0",
#                         "hot": "140",
#                         "spec": "1个"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/e77d2a237208403591d7cf69e075962b.jpg",
#                 "name": "Honey",
#                 "hot": "321cal / 100g",
#                 "id": "97937415672487",
#                 "company": [
#                     "g",
#                     "Spoon"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "321"
#                     },
#                     {
#                         "kg": "5.0",
#                         "hot": "16",
#                         "spec": "1Spoon"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/mid_photo_20128151119449905.jpg",
#                 "name": "Egg fried rice",
#                 "hot": "146cal / 100g",
#                 "id": "97937415673180",
#                 "company": [
#                     "g"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "146"
#                     }
#                 ]
#             },
#             {
#                 "icon": "http://www.xinyuekang.com.cn/data/upload/food/1166684171279_mid.jpg",
#                 "name": "Vegetable salad",
#                 "hot": "40cal / 100g",
#                 "id": "97937415674575",
#                 "company": [
#                     "g",
#                     "Bowl"
#                 ],
#                 "spec": [
#                     {
#                         "kg": "100",
#                         "hot": "40"
#                     },
#                     {
#                         "kg": "300.0",
#                         "hot": "121",
#                         "spec": "1Bowl"
#                     }
#                 ]
#             }
#         ]
#     }


# for e in data['food_list']:
#     Food(food_id=e['id'], name=e['name'], hot=e['hot'],
#         icon=e['icon'], company=e['company'], spec=e['spec']).save()
