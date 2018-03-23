# -*- coding: utf-8 -*-
#!/usr/bin/env python

from DB.DbClient import DbClient
from Util.GetConfig import GetConfig
from ProxyGetter.getFreeProxy import GetFreePorxy

class ProxyManager(object):
	"""docstring for ProxyManager"""
	def __init__(self):
		"""
		1、数据库代理、数据库配置初始化、合法有用代理队列初始化
		"""
		self.db = DbClient()
		self.config = GetConfig()
		self.raw_proxy_queue = 'raw_proxy'
		# self.log = LogHandler('proxy_manager')
		self.useful_proxy_queue = 'useful_proxy'
		self.freeProxyClient = GetFreePorxy()
		pass

	def refresh(self):
		"""
		fetch proxy in Db by ProxyGetter.
		"""
		for proxyGetter in self.config.proxy_getter_functions:
			proxy_set = set()
			print("Debug:proxyGetter "+str(proxyGetter) + " begin...")
			if getattr(self.freeProxyClient,proxyGetter)():
				for proxy in getattr(self.freeProxyClient,str(proxyGetter).strip())():
					print("Debug proxy = " + proxy.strip())
					if proxy.strip():
						print("Debug proxy = " + proxy.strip())
						proxy_set.add(proxy.strip())
				#更新数据表
				self.db.changeTable(self.raw_proxy_queue)
				for proxy in proxy_set:
					#把set中的proxy都增加到数据库中
					self.db.put(proxy)
			else:
				print("Debug:can not get proxyGetter")
			print("Debug:proxyGetter "+str(proxyGetter) + " end!!!")

	def get(self):
		#从数据库中获取有用代理并将结果返回
		self.db.changeTable(self.useful_proxy_queue)
		return self.db.get()

	def delete(self,proxy):
		#更新数据表，并从数据表中删除无效代理
		self.db.changeTable(self.useful_proxy_queue)
		return self.db.delete()

	def getAll(self):
		#更新数据表，从数据表中获取所有有效的代理
		self.db.changeTable(self.useful_proxy_queue)
		#将有效代理集合作为结果返回
		return self.db.getAll()

	def get_status(self):
		#刷新数据表
		self.db.changeTable(self.raw_proxy_queue)
		total_raw_proxy = self.db.get_status()
		#从数据表中获取状态，获取到所有原始代理
		#刷新数据表
		self.db.changeTable(self.useful_proxy_queue)
		total_useful_queue = self.db.get_status()
		#获取有用代理队列
		#返回所有原始代理，有用代理队列两个值
		return {'raw_proxy':total_raw_proxy,'useful_proxy':total_useful_queue}

if __name__ == '__main__':
	pp = ProxyManager()
	pp.refresh()
	print(pp.get_status())
