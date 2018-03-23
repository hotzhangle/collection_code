# -*- coding: utf-8 -*-
# !/usr/bin/env python

import os
import sys

from Util.utilClass import Singleton
from Util.GetConfig import GetConfig

sys.path.append(os.path.dirname(os.path.abspath(__file__)))

class DbClient(object):
	"""docstring for DbClient"""

	__metaclass__ = Singleton
	def __init__(self):
		self.config = GetConfig()
		self.__initDbClient()

	def __initDbClient(self):
		__type = None
		if "SSDB" == self.config.db_type:
			__type = "SsdbClient"
		elif "REDIS" == self.config.db_type:
			__type = "RedisClient"
		else:
			pass
		assert __type, 'type error,Not support DB type: {}'.format(self.config.db_type)
		#如果需要运行这个方法，可以在后面添加一对括号。
		self.client = getattr(__import__(__type),__type)(name=self.config.db_name,host=self.config.db_host,port=self.config.db_port)
		# print(self.config.db_type + " ready start...")
	def get(self,**kwargs):
		return self.client.get(**kwargs)

	def put(self,key,**kwargs):
		return self.client.put(key,**kwargs)

	def getvalue(self,key,**kwargs):
		return self.client.getvalue(key,**kwargs)

	def pop(self,**kwargs):
		return self.client.pop(**kwargs)

	def inckey(self,key,value,**kwargs):
		return self.client.inckey(key,value,**kwargs)

	def delete(self,key,**kwargs):
		return self.client.delete(key,**kwargs)

	def getAll(self):
		return self.client.getAll()

	def changeTable(self,name):
		return self.client.changeTable(name)

	def get_status(self):
		return self.client.get_status()


if __name__ == "__main__":
	account = DbClient()
	print(account.get())
	account.changeTable('use')
	account.put('ac')
	print(account.get())