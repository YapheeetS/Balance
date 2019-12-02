import tornado.web
import json
import config

class Send_task(tornado.web.RequestHandler):
    """Provide API for frontend to perform task creation and result visualization
       
    """

    def get(self, *arg, **kwargs):

        prob_dict = {
            'type' : 'ping',
            'url': 'www.baidu.com'
        }

        # self.write(json.dumps(prob_dict))
        self.write(prob_dict)

    def post(self):
        """
        """
        # get arguments from POST request body
        # type = get_body_argument('type', None)
        # self.write(type)


class Receive_mac(tornado.web.RequestHandler):
    """
    """
    def post(self, *args, **kwargs):
        # receive
        mac = eval(self.get_argument("mac"))
        print(mac)

        self.write(mac)



class Receive_data(tornado.web.RequestHandler):
    """
    """
    
    
    def post(self, *args, **kwargs):
        # receive
        task = eval(self.get_argument("task"))
        print(task)

        self.write(task)



# class Send_task(tornado.web.Websocket):
