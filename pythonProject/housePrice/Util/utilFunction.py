# -*- coding: utf-8 -*-
# !/usr/bin/env python

import requests
from requests.packages.urllib3.exceptions import InsecureRequestWarning

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
def getHTMLText(url,headers={'user': 'Mozilla/5.0'}):
	try:
		response = requests.get(url, headers=headers, timeout=10)
		response.raise_for_status()
		response.encoding = response.apparent_encoding
		return response.text
	except:
		return

def robustCrawl(func):
	def decorate(*args, **kwargs):
		try:
			return func(*args, **kwargs)
		except Exception as e:
			print(u"sorry, 抓取出错。错误原因:"+str(e))
	return decorate

def verifyProxy(proxy):
	import re
	verify_regex = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}"
	return True if re.findall(verify_regex, proxy) else False

def getHtmlTree(url,**kwargs):
	import requests
	from lxml import etree
	header = {'Connection': 'keep-alive',
			  'Cache-Control': 'max-age=0',
			  'Upgrade-Insecure-Requests': '1',
			  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko)',
			  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
			  'Accept-Encoding': 'gzip, deflate, sdch',
			  'Accept-Language': 'zh-CN,zh;q=0.8',
			  }
	# TODO 取代理服务器用代理服务器访问
	html = requests.get(url=url, headers=header, timeout=30)
	status_code = html.status_code
	if status_code != 200:
		print("Debug:url = "+ url + "-----status_code = " + str(status_code))

	return etree.HTML(html.content)

def validUsefulProxy(proxy):
	proxies = {"https": "https://{proxy}".format(proxy=proxy)}
	print("Type :" + str(proxies))
	try:
		# 超过20秒的代理就不要了
		r = requests.get('https://www.baidu.com', proxies=proxies, timeout=40, verify=False)
		if r.status_code == 200:
			print('%s is ok' % proxy)
			return True
	except Exception as e:
		# print(e)
		return False
