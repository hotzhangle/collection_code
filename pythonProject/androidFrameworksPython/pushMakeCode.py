#!/usr/bin/env python
import os

bottom,top,customerKey= 1,7,-1
class myDict(dict):
	def __inner_value(self,customerValue):
		for key,value in self.items():
			if value==customerValue:
				return True	#if the value is in my project dict,return true
		return False
	def has_value(self,customerValue):
		self.__inner_value(self,customerValue)

projectName = myDict({1:1580,2:1518,3:1519,4:732,5:733,6:700,7:806,8:816})	#define an object of myDict class to use has_value method,there I use a dict to shelve all project key and value

def listProjectName():
	for key,value in projectName.items():	#this I use a loop to list all the project
		print("%s:%s" %(key,value))		#python print format like print("stand signal" %(real data))

def getCustomerKey():
	global customerKey 	#there I mean to change global variable valule 'customerKey',so need to use global::about Variable scope
	try:
		customerKey=int(input('please input your project: '))	#in python,use signal'' to show String
		print("getCustomerKey %s" % customerKey)
	except Exception, e:
		print 'customerKey is null and will continue if 0 exit!!'	#show choice for customer

def getUserProjectInfo():
	listProjectName()
	getCustomerKey()

while 1:
	#deal with customerKey
	getUserProjectInfo()
	print("customerKey:%s" % customerKey)
	if customerKey==-1:
		continue
	if customerKey==0:
		exit()
	if (projectName.has_key(customerKey)):	#there is dict's has method
		customerKey = projectName.get(customerKey,None)
		print("you have choise project: %d" % customerKey)
		break
	elif (projectName.has_value(customerKey)):	#IndentationError: unindent does not match any outer indentation level
		pass
	else :
		print "invalid customerKey"	#IndentationError:expected an indented block

#1、find查找当前目录下的所有目录，最大深度两层
