# -*- coding: utf-8 -*-
# !/usr/bin/env python

class LazyProperty(object):
	"""docstring for LazyProperty"""
	def __init__(self, func):
		self.func = func

	def __get__(self,instance,owner):
		if instance is None:
			return self
		else:
			value = self.func(instance)
			setattr(instance,self.func.__name__,value)
			return value
try:
	from configparser import ConfigParser
except :
	from configparser import Configparser
	pass

class ConfigParse(ConfigParser):
	"""docstring for ConfigParse"""
	def __init__(self):
		ConfigParser.__init__(self)

	def optionxform(self,optionstr):
		return optionstr

class Singleton(type):
	"""docstring for Singleton"""
	_inst = {}

	def __call__(cls,*args,**kwargs):
		if cls not in cls._inst:
			cls._inst[cls] = super(Singleton,cls).__call__(*args)
		return cls._inst[cls]
