#!/usr/bin/env python

import re

number1,number2 = '010-12345','010 12345'
regularString = r'^\d{3}\-\d{3,8}$'
if re.match(regularString,number1):
    print 'ok'
elif re.match(regularString,number2):
    print 'fail'
string1 = 'a  b   c'
dict1 = string1.split(' ')
print dict1
del dict1,string1
regularStringSpace = r'[\s\,]+'
string2 = 'a,b, c  d'
print re.split(r'[\s\,]+','a,b,c d')
#print string2.split(regularStringSpace)
del string2,regularStringSpace

print re.split(r'[\s\,\;]+','a,b;;c d')

regularPhone = r'^(\d{3})-(\d{3,8})$'

m = re.match(regularPhone,'010-12345')
print m #this will print out the object address like <_sre.SRE_Match object at 0x7fd3d58910b8>
print("m.group(0):%s" % m.group(0))	#m.group(0):010-12345
print("m.group(1):%s" % m.group(1))	#m.group(1):010
print("m.group(2):%s" % m.group(2))	#m.group(2):12345

t = '19:05:30'
regularTime = r'^(0[0-9]|1[0-9]|2[0-3]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])\:(0[0-9]|1[0-9]|2[0-9]|3[0-9]|4[0-9]|5[0-9]|[0-9])$'
m = re.match(regularTime,t)
print m.groups()

print re.match(r'^(\d+?)(0*)$','102300').groups()	#nogreedy match , if greedy match, reduce '?'

regularTelephone = r'^(\d{3})-(\d{3,8})$'	#if a regular expression string will be used again,the best way is pre-compile this string
re_telephone = re.compile(regularTelephone)

print re_telephone.match('010-12345').groups()
print re_telephone.match('010-10086').groups()


