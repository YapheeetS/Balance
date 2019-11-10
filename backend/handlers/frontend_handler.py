# -*- coding: utf-8 -*-

import tornado.web
import json
import config
from models.agent_model import Agent
from models.task_model import Task
from mongoengine import *
from handlers.websocket_handler import *



class BaseHandler(tornado.web.RequestHandler):
    def set_default_headers(self):
        self.add_header('Access-Control-Allow-Origin', '*')
        self.set_header("Access-Control-Allow-Headers", "Content-Type,Access-Token,X-Token,x-requested-with")
        self.set_header('Access-Control-Allow-Methods', "GET, POST, OPTIONS, PUT")
        self.set_header('Access-Control-Allow-Credentials', '*')
        self.set_header('Access-Control-Expose-Headers', '*')


class Get_probe_list(BaseHandler):
    """Provide API for frontend to perform task creation and result visualization
    """
    def get(self, *arg, **kwargs):
        ip_list = []
        mac_list = []
        agents = Agent.get_all_agent()
        for agent in agents:
                # data.append({'id': str(agent.id), 'ip':str(agent.ip), 'mac': str(agent.mac)})
                ip_list.append(str(agent.ip))
                mac_list.append(str(agent.mac))

        prob_dict = {
            'ip_list': ip_list,
            'mac_list': mac_list
        }
        self.write(json.dumps(prob_dict))

    def post(self):
        """
        """
        # get arguments from POST request body
        type = self.get_body_argument('type', None)
        self.write(type)


class Submit_task(BaseHandler):
    """
    """
    def post(self, *args, **kwargs):
        # receive
        task_name = str(self.get_argument("task_name"))
        task_type = str(self.get_argument("type"))
        destination = str(self.get_argument("destination"))
        interval = str(self.get_argument("interval"))
        macs = str(self.get_argument("mac"))
        macs = macs.split(',')
        agents = []
        for mac in macs:
            agent = Agent.get_agent_with_mac(mac)
            agents.append(agent)
        task = Task.create_task(task_name, task_type, destination, interval, agents)

        self.write(str(task.name)+'创建成功')
        # WebSocketHandler.write_message()
        for mac in macs:
            all_agent[mac].write_message({"task_name": task_name,
                                          "task_type": task_type,
                                          "destination": destination,
                                          "interval": interval,
                                          #   "agents": agents
                                          })

class Show_tasks(BaseHandler):
    """Select all tasks from mongoDB without any parameters.
    """
    def get(self):
        data = Task.get_all_task()
        name_list = []
        id_list = []
        for task in data:
            name_list.append(task.name)
            id_list.append(str(task.id))
        tasks = {'task_list':name_list, 'id_list': id_list}

        self.write(json.dumps(tasks))


class Display_task(BaseHandler):
    """TODO:To display task, frontend should set parameter of task id!
    """
    def get(self):

        # select one task from mongodb
        tasks = {'task_name': 'Hello World',
                 'type': 'ping',
                 'destination': 'www.baidu.com',
                 'mac': {'mac1': {'packet_loss': ['0.0%', '0.0%', '0.0%'],
                                  'rtt_avg': ['15.411', '15.411', '15.411'],
                                  'rtt_stddev': ['10.175', '10.175', '10.175'],
                                  },
                         'mac2': {'packet_loss': ['0.0%', '0.0%', '0.0%'],
                                  'rtt_avg': ['15.411', '15.411', '15.411'],
                                  'rtt_stddev': ['10.175', '10.175', '10.175'],
                                  },
                         }
                 }
        self.write(tasks)

    def post(self, *args, **kwargs):
        # receive
        task_id = str(self.get_argument("task_id"))
        data = Task.get_task_with_id(task_id)
        agent_list = []
        for agent in data.agents:
            agent_list.append(
                {agent.mac: {'packet_loss': agent.packet_loss, 'rtt_avg': agent.delay, 'rtt_stddev': agent.shake}})

        task = {'task_name': data.name,
                'type': data.task_type,
                'destination': data.destination,
                'interval':data.interval,
                'mac': agent_list
                }

        self.write(task)

