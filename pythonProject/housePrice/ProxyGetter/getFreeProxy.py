# _*_ coding: utf-8 _*_
#!/usr/bin/env python

import re
import requests

try:
	from importlib import reload
except :
	import sys
	reload(sys)
	sys.setdefaultencoding('utf-8')

from Util.utilFunction import robustCrawl,getHtmlTree,getHTMLText

requests.packages.urllib3.disable_warnings()

HEADER = {'Connection': 'keep-alive',
          'Cache-Control': 'max-age=0',
          'Upgrade-Insecure-Requests': '1',
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko)',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'Accept-Encoding': 'gzip, deflate, sdch',
          'Accept-Language': 'zh-CN,zh;q=0.8',
          }

class GetFreePorxy(object):
	"""docstring for GetFreePorxy"""
	def __init__(self):
		# print("Debug:GetFreePorxy __init__")
		pass

	#9-20 00:07 debug ok.
	@staticmethod
	@robustCrawl
	def freeProxyFirst(page=10):
		"""快代理IP"""
		url_list = ('http://www.kuaidaili.com/free/inha/{page}/'.format(page=page) for page in range(1,page +1 ))
		isPrintLen = True

		for url in url_list:
			tree = getHtmlTree(url)
			proxy_list = tree.xpath('.//div[@id="list"]//tbody/tr')
			if isPrintLen:
				print("Debug:proxy_list = " + str(len(proxy_list)))
				isPrintLen = False
			for proxy in proxy_list:
				ip = proxy.xpath('./td[@data-title="IP"]')[0].text
				port = proxy.xpath('./td[@data-title="PORT"]')[0].text
				ipSet = (ip,port)
				# realIP = ':'.join(ipSet)
				print("Debug: proxy = " + realIP)
				yield ':'.join(ipSet)

	@staticmethod
	@robustCrawl
	def freeProxySecond(proxy_number=10):
		"""代理66 http://www.66ip.cn"""

		url_list = ('http://m.66ip.cn/{proxy_number}.html'.format(proxy_number=proxy_number) for page in range(1,proxy_number+1))
		# print("Debug:freeProxySecond begin")
		for url in url_list:
			html = getHTMLText(url,headers=HEADER)
			for proxy in re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}',html):
				yield proxy

	@staticmethod
	@robustCrawl
	def freeProxyThird(days=1):
		"""
		抓取有代理 http://www.youdaili.net/Daili/http/
		"""
		url = "http://www.youdaili.net/Daili/http/"
		tree = getHtmlTree(url)
		page_url_list = tree.xpath('.//div[@class="chunlist"]/ul/li/p/a/@href')[0:days]
		for page_url in page_url_list:
			html = requests.get(page_url,headers=HEADER).content
			#print html
			proxy_list = re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}',html)
			for proxy in proxy_list:
				yield proxy

	@staticmethod
	@robustCrawl
	def freeProxyFourth(page=10):
		import re
		"""抓取西刺代理 http://api.xicidaili.com/free2016.txt"""
		url_list = ['http://www.xicidaili.com/nn',  # 高匿
					'http://www.xicidaili.com/nt',  # 透明
					]
		url_list = ('http://www.xicidaili.com/nt/{page}/'.format(page=page) for page in range(1, page + 1))
		for each_url in url_list:
			tree = getHtmlTree(each_url)
			proxy_list = tree.xpath('.//table[@id="ip_list"]//td')
			# print("Debug: freeProxyFourth " + str(len(proxy_list)))
			ip = ""
			port = ""
			for proxy in proxy_list:
				if re.match('(\d{1,3}\.){3}\d{1,3}',str(proxy.text)):
					# print("Debug: freeProxyFourth " + str(proxy.text))
					ip = str(proxy.text)
				elif re.match('^\d{1,5}$',str(proxy.text)):
					# print("Debug: freeProxyFourth " + str(proxy.text))
					port = str(proxy.text)
				else:
					continue
				ipSet = (ip,port)
				# realIP = ':'.join(ipSet)
				print("Debug: freeProxyFourth " + str(realIP))
				yield ':'.join(ipSet)

	@staticmethod
	@robustCrawl
	def freeProxyFifth(endPage=10):
		"""
		抓取guobanjia http://www.goubanjia.com/free/gngn/index.shtml
		"""
		url = "http://www.goubanjia.com/free/gngn/index{page}.shtml"
		for page in range(1,endPage):
			page_url = url.format(page=page)
			tree = getHtmlTree(page_url)
			proxy_list = tree.xpath('//td[@class="ip"]')
			for each_proxy in proxy_list:
				yield ''.join(each_proxy('.//text()'))

if __name__ == '__main__':
	gg = GetFreePorxy()
	# for e in gg.freeProxyFirst():
	# 	print e

	# for e in gg.freeProxySecond():
	# print e

	# for e in gg.freeProxyThird():
	# print e

	# for e in gg.freePorxyFourth():
	# print e

	for e in gg.freeProxyFifth():
		print (e)

