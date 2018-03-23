#!/usr/bin/env python

from HTMLParser import HTMLParser
import urllib

class MyHTMLParser(HTMLParser):
	"""docstring for MyHTMLParser"""
	def __init__(self):
		HTMLParser.__init__(self)
		self.key = {'time':None,'event-title':None,'event-location':None}

	def handle_starttag(self,tag,attrs):
		if tag == 'time':
			self.key['time'] = True
		elif tag == 'span' and attrs.__contains__(('class','event-location')):
			self.key['event-location'] = True
		elif tag == 'h3' and attrs.__contains__(('class','event-title')):
			self.key['event-title'] = True

	def handle_data(self,data):
		if self.key['time']:
			print 'Time:%s\t|' % data,
			self.key['time'] = None
		elif self.key['event-title']:
			print 'Title:%s\t|' % data,
			self.key['event-title'] = None
		elif self.key['event-location']:
			print 'Location:%s\t|' % data,
			self.key['event-location'] = None

parser = MyHTMLParser()
html = urllib.urlopen('http://www.python.org/events/python-events/').read()
parser.feed(html)
