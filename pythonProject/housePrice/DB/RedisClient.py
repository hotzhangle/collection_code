# _*_ coding: utf-8 _*_
#!/usr/bin/env python

import json
import random
import redis

class RedisClient(object):
	"""docstring for RedisClient"""
	def __init__(self,name,host,port):
		self.name = name
		# print("Debug: RedisClient init.")
		self.__conn = redis.Redis(host = host,port = port,db = 0)

	def get(self):
		key = self.__conn.hgetall(name=self.name)
		print("Debug getKey len = " + str(len(key)))
		return random.choice(list(key.keys())) if key else None

	def put(self,key):
		key = json.dumps(key) if isinstance(key,(dict,list)) else key
		return self.__conn.hincrby(self.name,key,1)

	def getvalue(self,key):
		value = self.__conn.hget(self.name,key)
		return value if value else None

	def pop(self):
		key = self.get()
		print("Debug: key = " + str(key))
		if key:
			self.__conn.hdel(self.name,key)
		return key

	def delete(self,key):
		self.__conn.hdel(self.name,key)

	def inckey(self,key,value):
		self.__conn.hincrby(self.name,key,value)

	def getAll(self):
		# print("Debug: getAll " + self.name)
		return self.__conn.hgetall(self.name).keys()

	def get_status(self):
		return self.__conn.hlen(self.name)

	def changeTable(self,name):
		# print("Debug: changeTable " + name)
		self.name = name

if __name__ == '__main__':
	redis_con = RedisClient('proxy', 'localhost', 6937)
	# redis_con.put('abc')
	# redis_con.put('123')
	# redis_con.put('123.115.235.221:8800')
	# redis_con.put(['123','115','235.221:8800'])
	# print(redis_con.getAll())
	# redis_con.delete('abc')
	# print(redis_con.getAll())

	# print(redis_con.getAll())

	redis_con.changeTable('raw_proxy')
	redis_con.pop()

	# redis_con.put('132.112.43.221:8888')
	# redis_con.changeTable('proxy')

	print(redis_con.get_status())
	print(redis_con.getAll())
