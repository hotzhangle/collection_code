# _*_ coding:utf-8 _*_
#!/usr/bin/env python

"""
from ssdb.connection import BlockingConnectionPool
from ssdb import SSDB
import random
import json
"""
class SsdbClient(object):
	"""docstring for SsdbClient"""
	"""
	def __init__(self,name,host,port):
		self.name = name
		self.__conn = SSDB(connection_pool=BlockingConnectionPool(host=host,port=port))

	def get(self):
		values = self.__conn.hgetall(name=self.name)
		return random.choice(values.keys()) if values else None

	def put(self,key):
		key = json.dump(key,ensure_ascii=False).encode('utf-8') if isinstance(key,(dict,list)) else key
		return self.__conn.hincr(self.name,key,1)

	def getvalue(self,key):
		value = self.__conn.hget(self.name,key)
		return value if value else None

	def pop(self):
		key = self.get()
		if key:
			self.__conn.hdel(self.name,key)
		return key

	def delete(self,key):
		self.__conn.hdel(self.name,key)

	def inckey(self,key,value):
		self.__conn.hgetall(self.name).keys()

	def getAll(self):
		return self.__conn.hgetall(self.name).keys()

	def get_status(self):
		return self.__conn.hsize(self.name)

	def changeTable(self,name):
		self.name = name
"""