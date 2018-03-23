# -*- coding: utf-8 -*-
# !/usr/bin/env python

import sys
sys.path.append('../')
from multiprocessing import Process

from Api.ProxyApi import run as ProxyApiRun
from Schedule.ProxyValidSchedule import run as ValidRun
from Schedule.ProxyRefreshSchedule import run as RefreshRun

def run():
	p_list = list()
	p1 = Process(target=ProxyApiRun,name='ProxyApiRun')
	p_list.append(p1)
	p3 = Process(target=RefreshRun,name='RefreshRun')
	p_list.append(p3)
	p2 = Process(target=ValidRun,name='ValidRun')
	p_list.append(p2)

	for p in p_list:
		p.start()
	for p in p_list:
		p.join()

if __name__ == '__main__':
	run()