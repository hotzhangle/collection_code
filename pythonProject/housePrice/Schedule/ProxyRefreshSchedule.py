# -*- coding: utf-8 -*-
# !/usr/bin/env python
import sys
sys.path.append('../')

import time

from threading import Thread
from apscheduler.schedulers.blocking import BlockingScheduler
from Util.utilFunction import validUsefulProxy
from Manager.ProxyManager import ProxyManager

class ProxyRefreshSchedule(object):
	"""代理定時刷新"""
	def __init__ (self):
		ProxyManager.__init__(self)
		#debug log

	def validProxy(self):
		"""
		验证raw_proxy_queue中的代理，将可用的代理放入useful_proxy_queue
		"""
		self.db.changeTable(self.raw_proxy_queue)
		raw_proxy = self.db.pop()
		print("Debug: " + str(raw_proxy))
		exist_proxy = self.db.getAll()
		while raw_proxy:
			"""
			1、合法有用的代理且代理在数据库中不存在
			2、更新数据表
			3、记录log
			"""
			print("debug :" + str(raw_proxy))
			if validUsefulProxy(raw_proxy) and (raw_proxy not in exist_proxy):
				self.db.changeTable(self.useful_proxy_queue)
				self.db.put(raw_proxy)
				#debug log
			else:
				#debug log
				pass
			self.db.changeTable(self.raw_proxy_queue)
			raw_proxy = self.db.pop()
		#debug log
def refreshPool():
	pp = ProxyRefreshSchedule()
	# print("Debug: validProxy check begin")
	pp.validProxy()
	# print("Debug: validProxy check end")


def main(process_num=5):
	p = ProxyRefreshSchedule()

	ProxyManager().refresh()

	p1 = []

	for num in range(process_num):
		proc = Thread(target=refreshPool,args=())
		p1.append(proc)

	for num in range(process_num):
		p1[num].start()

	for num in range(process_num):
		p1[num].join

def run():
	main()
	sched = BlockingScheduler()
	sched.add_job(main,'interval',minutes=5)
	sched.start()


if __name__ == '__main__':
	run()