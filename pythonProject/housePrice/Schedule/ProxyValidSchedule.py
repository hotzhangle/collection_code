"""
# -*- coding: utf-8 -*-
# !/usr/bin/env python
"""
import sys
sys.path.append('../')

from Util.utilFunction import validUsefulProxy
from Manager.ProxyManager import ProxyManager

class ProxyValidSchedule(object):
	"""docstring for ProxyValidSchedule"""
	def __init__(self):
		ProxyManager.__init__(self)
		"""init loghandler"""

	def __validProxy(self):
		"""
		1、检查prxoy 的有效性
		2、增加/删除 合法/非法的Proxy到数据库中
		"""
		while True:
			#打印有效代理的log
			self.db.changeTable(self.useful_proxy_queue)
			__proxy_list = []
			try:
				__proxy_list =self.db.getAll()
				# print("try get proxy from db.")
			except EnvironmentError as e:
				print("Something wrong with get proxy from db client" + str(e))
				del __proxy_list
				break
			if __proxy_list:
				for each_proxy in __proxy_list:
					if isinstance(each_proxy,bytes):
						each_proxy = each_proxy.decode('utf-8')

					if validUsefulProxy(each_proxy):
						self.db.inckey(each_proxy,1)
						#debug log
					else:
						self.db.inckey(each_proxy,-1)
						#debug log
					value = self.db.getvalue(each_proxy)
					if value and int(value) < -5:
						self.db.delete(each_proxy)
			else:
				# print("Can not get anything from db client")
				pass
		#debug log
	def main(self):
		self.__validProxy()

def run():
	p = ProxyValidSchedule()
	p.main()

if __name__ == '__main__':
	p = ProxyValidSchedule()
	p.main()
