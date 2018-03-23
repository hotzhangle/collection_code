import urllib.request
import requests
import urllib
import socket
import threading
import re, time, random

ip_total = []

def getUserAgent():
    UserAgent_List = [
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1",
        "Mozilla/5.0 (X11; CrOS i686 2268.111.0) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1092.0 Safari/536.6",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.6 (KHTML, like Gecko) Chrome/20.0.1090.0 Safari/536.6",
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/19.77.34.5 Safari/537.1",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.9 Safari/536.5",
        "Mozilla/5.0 (Windows NT 6.0) AppleWebKit/536.5 (KHTML, like Gecko) Chrome/19.0.1084.36 Safari/536.5",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1063.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1062.0 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.1 Safari/536.3",
        "Mozilla/5.0 (Windows NT 6.2) AppleWebKit/536.3 (KHTML, like Gecko) Chrome/19.0.1061.0 Safari/536.3",
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24",
        "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/535.24 (KHTML, like Gecko) Chrome/19.0.1055.1 Safari/535.24"
    ]
    return random.choice(UserAgent_List)

def get_header():
    headers = {
        'User-Agent': getUserAgent(),
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'zh-CN,zh;q=0.8',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Cookie': '_free_proxy_session=BAh7B0kiD3Nlc3Npb25faWQGOgZFVEkiJWIxYjAwZDkxMDE1NWRiYjAwMTBjZTFjZGY3YjJjMjE4BjsAVEkiEF9jc3JmX3Rva2VuBjsARkkiMXE5aGt6cDdPU2tyajI4RjB2dENmZS9aT0RMTDVTK1R2d1hTMDVjUGYxT0E9BjsARg%3D%3D--a913aa7825c13fec2fdfd583519c69b3345ab87b; CNZZDATA1256960793=284076470-1468134027-null%7C1468307148',
        'DNT': '1',
        'Host': 'www.xicidaili.com',
    }
    return headers

for page in range(2, 6):
    # url='http://ip84.com/dlgn/'+str(page)
    url = 'http://www.xicidaili.com/wt/' + str(page)
    # headers = {"UserAgent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"}

    # request = urllib.request.Request(url=url, headers=headers)
    r = requests.get(url, headers=get_header())
    text = r.text
    # print('reqest OK.',type(request))
    # response = urllib.request.urlopen(url)
    print('response OK.', type(text))
    # content = request.read().decode('utf-8')
    print('get page ', page)
    pattern = re.compile('<td>(\d.*?)</td>')
    ip_page = re.findall(pattern=pattern, string=text)
    ip_total.extend(ip_page)
    time.sleep(random.choice(range(1, 3)))

print('代理IP地址     ', '\t', '端口', '\t', '速度', '\t', '验证时间', '\t', len(ip_total))
for i in range(0, len(ip_total), 4):
    print("i = %s" % str(i), ip_total[i], '\t', ip_total[i + 1], '\t', ip_total[i + 2], '\t', ip_total[i + 3])

print('End print all address.')
proxys = []
for i in range(0, len(ip_total), 4):
    proxy_host = ip_total[i] + ":" + ip_total[i + 1]
    proxy_temp = {'http': proxy_host}
    proxys.append(proxy_temp)

proxy_ip = open('proxy_ip.txt', 'a')
lock = threading.Lock()

def test(i):
    socket.setdefaulttimeout(5)
    url = 'http://www.stockstar.com/'
    proxy_support = urllib.request.ProxyHandler(proxys[i])
    opener = urllib.request.build_opener(proxy_support)
    opener.addheaders = [("User-Agent",
                          "Mozilla/5.0 (Windows NT 6.1; Win64; x64) Chrome/59.0.3071.115 AppleWebKit/537.36 (KHTML, like Gecko) Safari/537.36")]
    urllib.request.install_opener(opener)
    # TRY_MAX_NUM = 5
    try:
        lock.acquire()
        res = urllib.request.urlopen(url).read()
        print("i = %s" % str(i), proxys[i], 'is OK')
        proxy_ip.write('%s\n ' % (str(proxys[i])))
        lock.release()
    except Exception as e:
        # if i < TRY_MAX_NUM -1:
        #     lock.release()
        # else:
            # print(proxys[i], e)
        print ('URLError: <urlopen error timed out> All times is failed :',proxys[i], e)
        lock.release()
    # for i in range(TRY_MAX_NUM):
    #     pass

threads = []
for i in range(len(proxys)):
    # if i > 20:
    #     print('stop IP test.')
    #     break
    thread = threading.Thread(target=test(i), args=[i])
    threads.append(thread)
    thread.start()

for thread in threads:
    thread.join()

proxy_ip.close()
