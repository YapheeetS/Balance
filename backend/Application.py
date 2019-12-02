import tornado.web
from handlers import frontend_handler
from handlers import probe_handler
from handlers import user_handler
from handlers import food_handler
from handlers import diet_handler
from handlers import activity_handler
from handlers import sport_handler
from handlers import balance_handler
import config

class Application(tornado.web.Application):
    """ Application inherited from tornado.

    """
    def __init__(self):
        handlers = [
            # 
            (r'/probe_list', frontend_handler.Get_probe_list),
            (r'/submit_task', frontend_handler.Submit_task),
            (r'/show_tasks', frontend_handler.Show_tasks),
            (r'/display_task', frontend_handler.Display_task),
            (r'/send_task', probe_handler.Send_task),
            (r'/receive_mac', probe_handler.Receive_mac),
            (r'/receive_data', probe_handler.Receive_data),

            (r'/create_user', user_handler.create_user),
            (r'/get_user', user_handler.get_user_info),
            (r'/login', user_handler.login),
            (r'/get_common_food', food_handler.get_common_food),
            (r'/search_food_with_name', food_handler.search_food_with_name),
            (r'/get_diet', diet_handler.get_diet),
            (r'/add_food', diet_handler.add_food),
            (r'/get_activities', activity_handler.get_activities),
            (r'/get_sport', sport_handler.get_sport),
            (r'/add_activity', sport_handler.add_activity),
            (r'/upload_steps_and_distance', sport_handler.upload_steps_and_distance),
            (r'/get_balance_data', balance_handler.get_balance_data)
            
        ]
        super(Application, self).__init__(handlers, **config.settings)
    # # TODO: we need a perf in record perf mac and ip??
    # perf_dict = dict()

    # def load_hander_module(self, handler_module, prefix=".*$"):
    #     """ from module import requesthandler
    #     Arguments:
    #         handler_module: a class contains a list of
    #             functions
    #     Returns:
    #         none: 
    #     """
    #     handlers = []
    #     # check out functions from hander and add them
    #     # into tornado application
    #     for i in dir(handler_module):
    #         cls = getattr(handler_modules, i)
    #         handlers.append((cls.url_pattern, cls))

    #     self.add_handlers(prefix, handlers)

if __name__ == "__main__":
    a = Application()


    
