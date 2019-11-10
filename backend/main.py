# from handlers import perf_test

import tornado.ioloop
import tornado.web
import argparse
import Application
import config
from handlers import *

def connect(port):
    """start server with assigned port. Note that 
    Application is inherited from Tornado!
        
    # Arguments:
        port: a int number passed from argparse
    # Returns:
        None:
    """
    application = Application.Application()
    application.listen(port)
    tornado.ioloop.IOLoop.instance().start()

if __name__ == "__main__":
    # port as parameter to run the server
    # Note that there are: 50111 - 50115 are avaliable
    parser = argparse.ArgumentParser(description='Network Software Design Homework')
    parser.add_argument('-P', '--port', type=int, help='running port')
    args = parser.parse_args()
    
    if not args.port:
        print("Parameter port is necessary!")
    else:
        # connect the server
        connect(args.port)


