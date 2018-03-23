#!/usr/bin/env python

import socket

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(('127.0.0.1',9999))

print s.recv(1024)

for data in ['Michael','Tracy','Sarah']:	#give a list to server,if server response,will print hello+'name'
	s.send(data)
	print s.recv(1024)
s.send('exit')
s.close()
