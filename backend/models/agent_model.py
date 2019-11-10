# -*- coding: utf-8 -*-

from mongoengine import *

# connect(db='sd', 
#         host='10.3.242.253',
#         port=27017,
#         username='sd',
#         password='software_design'
#         )   
connect('software_db', host='localhost', port=27017)

class Agent(Document):

    mac = StringField(required=True, primary_key=True)
    ip = StringField()
    state = StringField() #'on'  'off'
    delay = ListField()
    shake = ListField()
    packet_loss = ListField()

    # 所有探针
    @classmethod
    def get_all_agent(cls):
        objs = cls.objects
        return objs

    # 所有未被使用的探针
    @classmethod
    def get_off_agent(cls):
        objs = cls.objects(state='off')
        return objs

    # 根据mac获取探针
    @classmethod
    def get_agent_with_mac(cls, mac):
        obj = cls.objects(mac=mac).first()
        return obj

    # 创建探针
    @classmethod
    def create_agent(cls,mac,state='off', delay=[], shake=[], packet_loss=[]):
        # try:
        obj = cls(mac=mac, state=state, delay=delay, shake=shake, packet_loss=packet_loss).save()
            
        # except Exception:
        #     print('创建任务失败')
        #     return False
        return obj

    # 更新探针数据
    @classmethod
    def update_data_with_mac(cls,mac,delay,shake,packet_loss):
        # try:
        obj = cls.objects(mac=mac).first()
        obj.delay.append(delay)
        obj.shake.append(shake)
        obj.packet_loss.append(packet_loss)
        obj.save()


if __name__ == '__main__':
    # local test
    # connect('software_db', host='localhost', port=27017)

    # server test
    connect(db='sd', 
            host='10.3.242.253',
            port=27017,
            username='sd',
            password='software_design'
            )

    # register_connection()
    # connect('software_db', host='10.3.242.253', port=27017)

    Agent.create_agent(mac='111')
    Agent.create_agent(mac='222')
    Agent.create_agent(mac='333')
    Agent.create_agent(mac='444')

    agent = Agent.get_agent_with_mac('222')
    print(agent)
    updated_agent = agent.update(packet_loss=['hhh', 'eqwe'])
    print(updated_agent)
