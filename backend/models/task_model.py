# -*- coding: utf-8 -*-
from mongoengine import *
from models.agent_model import Agent

# connect(db='sd', 
#         host='10.3.242.253',
#         port=27017,
#         username='sd',
#         password='software_design'
#         )

connect('software_db', host='localhost', port=27017)

class Task(Document):
    """Saving and reading data with mongoDB.
    """

    name = StringField(required=True)
    task_type = StringField(required=True)
    destination = StringField(required=True)
    interval = StringField(required=True)
    agents = ListField(required=True)
    spec = ListField(required=True)

    @classmethod
    def get_all_task(cls):
        """Get all task from mongodb
        Arguments: 
            None
        Returns:
            objs: an object of mongoengine
        """
        objs = cls.objects
        return objs

    @classmethod
    def create_task(cls, name, task_type, destination, interval, agents):
        """create task from frontend
        Arguments:
            name: a str of task name
            task_type: a str of task type
            destination: a str of url
            interval: a str of number represents time
            agents: a list of avialiable agents
        Returns:
            obj: an object of mongoengine
        """

        obj = cls(name=name, task_type=task_type, destination=destination, interval=interval, agents=agents).save()
        # Update agent state for task
        for agent in agents:
            agent.update(state='on')
        return obj

    # @classmethod
    # def get_task_data(cls, task_id):


    @classmethod
    def get_agents_with_id(cls, task_id):
        """Get agents id according to task id for frontend display
        """
        obj = cls.objects(id=task_id).first()
        return obj.agents

    @classmethod
    def get_task_with_id(cls, task_id):
        """Get tasks id according to task id for frontend display
        """
        obj = cls.objects(id=task_id).first()
        return obj

    # 结束任务，并重置探针数据
    @classmethod
    def end_task(cls, task_id):
        """
        """

        agents = cls.get_agents_with_id(task_id)
        for agent in agents:
            agent.update(state='off')
            agent.update(delay=[])
            agent.update(shake=[])
            agent.update(packet_loss=[])

        obj = cls.objects(id=task_id).first()
        obj.delete()
        return


if __name__ == '__main__':
    # local test
    # connect('software_db', host='localhost', port=27017)

    # server test zzy
    connect(db='sd', 
            host='10.3.242.253',
            port=27017,
            username='sd',
            password='software_design'
            )
    data = []
    agents = Agent.get_all_agent()
    for agent in agents:
        if agent.mac == '222':
            data.append(agent)

    task1 = Task.create_task(name='task2',task_type='ping',destination='www.baidu.com',interval='5',agents=data)

    task = Task.get_all_task().first()
    print(task.id)
    agents = Task.get_agents_with_id(task.id)
    print(agents[0].state)
    print(agents[0].packet_loss)

    task = Task.get_all_task().first()
    Task.end_task(task.id)
