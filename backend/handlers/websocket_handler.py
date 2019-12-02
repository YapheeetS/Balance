# -*- coding: utf-8 -*-
import tornado
import tornado.web
import tornado.websocket
import tornado.ioloop
from models.agent_model import Agent
import json
import os


all_agent = dict()

class WebSocketHandler(tornado.websocket.WebSocketHandler):

    def open(self, *args, **kwargs):
        print("websocket opened")
        mac = self.get_argument("mac")

        all_agent[str(mac)] = self
        print(all_agent)
        Agent.create_agent(str(mac))

    def on_close(self):
        """call this function when server is closing
        """
        # del all_agent[mac]
        # self.write_message(str(mac) + " is closed.")

    def on_message(self, message):
        """call this function when receive message
        """
        self.write_message("You said: " + message)
        print(message)
        print(type(message))
        msg = json.loads(message)
        # print(msg['mac'], msg['rtt_avg'], msg['rtt_stddev'], msg['packet_loss'])
        try:
            Agent.update_data_with_mac(msg['mac'], msg['rtt_avg'], msg['rtt_stddev'], msg['packet_loss'])
        except Exception as e:
            print("something wrong")
            pass

    # def callback(self, count):
    #     self.write_message('{"inventorycount":"%s"}' % count)


class IndexPageHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("websockets.html")


class Application(tornado.web.Application):
    def __init__(self):
        handlers = [
            (r'/', IndexPageHandler),
            (r'/ws', WebSocketHandler)
        ]

        settings = {
            'template_path': 'static'
        }
        tornado.web.Application.__init__(self, handlers, **settings)


if __name__ == '__main__':
    ws_app = Application()
    server = tornado.httpserver.HTTPServer(ws_app)
    server.listen(50112)
    tornado.ioloop.IOLoop.instance().start()

