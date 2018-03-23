#!/usr/bin/python
#-*- coding:utf-8 -*-

#author:dasuda
#CSDN blog:HelloHaibo
#data:2017.8.25

import urllib2
import re
import socket
import threading
import global_para
# import targetURLs
import random
import datetime
import time
import user_agents
# import get_first_ip
import os

#thread lock
lock = threading.Lock()

#get ip and port from html
def html_to_ip(html):
    a = re.compile(r'(?<=<td>)[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}')
    b = re.compile(r'(?<=<td>)[\d]{2,5}(?=</td>)')
    html_to_ip_ip_table=[]
    findIP = re.findall(a, str(html))
    findPORT = re.findall(b, str(html))
    for i in range(len(findIP)):
        temp = findIP[i] + ":" + findPORT[i]
        html_to_ip_ip_table.append(temp)
    # html_to_ip_ip_table is a list
    return html_to_ip_ip_table

#thread function
#para1: 0 -> get 1->attack
def get_one(url_get,good_ip,cnt,para1,para2):
    #open url timeout
    socket.setdefaulttimeout(5)
    try:
        #assemble ip like {'http':'1.1.1.1:8888'}
        aseemble_ip = {'http': 'http://' + good_ip}
        # print("Debug:[get_one] good_ip = " + 'http://' + good_ip)
        proxy_support = urllib2.ProxyHandler(aseemble_ip)
        openercheck = urllib2.build_opener(proxy_support)
        urllib2.install_opener(openercheck)
        if para1 == 0:
            temp_url_get = url_get+str(random.randint(1,10))
        elif para1==1:
            temp_url_get = url_get
        print("Debug:[get_one] temp_url_get = " + temp_url_get)
        # request = urllib2.Request(temp_url_get)
        request = urllib2.Request("https://www.baidu.com")

        temp_agent = random.choice(user_agents.user_agents)
        print("Debug temp_agent = " + str(temp_agent))
        request.add_header('User-Agent',temp_agent)
        reponse = urllib2.urlopen(request)
        # print("Debug real_url = " + str(reponse.geturl()))
        print("Debug error_code = " + str(reponse.getcode()))
        content = reponse.read()

        if para1 == 0:
            # print content
            tt = html_to_ip(content)
            print ('this one is ok ',temp_url_get)
            lock.acquire()
            #print(global_para.IP_data[i],'is OK')
            if len(global_para.IP_data) <= cnt:
                global_para.IP_data.extend(tt)
            temp_tt = {}.fromkeys(global_para.IP_data).keys()
            print ('temp_tt:',len(temp_tt))
            global_para.IP_data= temp_tt
            lock.release()
            openercheck.close()
        elif para1 == 1:
            openercheck.close()
    except Exception as e:
        print("Debug [get_one] error:" + str(e))
        lock.acquire()
        if para1 == 0:
            good_ip = good_ip
        elif para1 ==1:
            if len(global_para.IP_data) >= para2:
                if good_ip in global_para.IP_error_list:
                    global_para.IP_error_list.remove(good_ip)
                    if good_ip in global_para.IP_data:
                        global_para.IP_data.remove(good_ip)
                    print ('now drop ip:%s' %good_ip)
                    print ('proxy ip left:%d' %len(global_para.IP_data))
                else:
                    global_para.IP_error_list.append(good_ip)
                    print ('ip:%s go to IP_error_list' %good_ip)
                    print ('IP_error_list:',len(global_para.IP_error_list))
        #print('error')
        lock.release()

def mul_thread_get(url_mul_get,get_counter,get_mode,go_refresh):
    threads = []
    for i in range(len(global_para.IP_data)):
        thread = threading.Thread(target=get_one, args=[url_mul_get,global_para.IP_data[i],get_counter,get_mode,go_refresh,])
        threads.append(thread)
#        thread.start()
        #print "new thread start",i
    for thr in threads:
        thr.start()

    for thread in threads:
        thread.join()
    if get_mode==0:
        if len(global_para.IP_data) >= get_counter:
            print ('ok,get ip done')
            return 1
        else:
            # print ('getting ip...')
            return 0
    elif get_mode == 1:
        if len(global_para.IP_data) <= go_refresh:
            return 0
        else:
            return 1

if __name__ == '__main__':
    # url_list = ('http://www.kuaidaili.com/free/inha/{page}/'.format(page=page) for page in range(1,global_para.page +1 ))
    url_list = ('http://www.kuaidaili.com/free/inha/'.format(page=page) for page in range(1,global_para.page +1 ))
    for url in url_list:
        print("Debug url = " + url)
        # while url_list.next():
        rez = mul_thread_get(url,20,0,0)#网址自行脑补，免费的网站就那几个
        if rez == 0:
            time.sleep(1)
            continue
        else:
            print ('get over!!!!!!!!!')#此时global_para.IP_data里面为获取到的IP