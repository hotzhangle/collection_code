* 其他文件:

　　配置文件:Config.ini,数据库配置和代理获取接口配置，可以在GetFreeProxy中添加新的代理获取方法，并在Config.ini中注册即可使用；
### 4、安装

下载代码:
```
git clone git@github.com:jhao104/proxy_pool.git

或者直接到https://github.com/jhao104/proxy_pool 下载zip文件
```

安装依赖:
```
pip install -r requirements.txt
```

启动:

```
如果你的依赖已经安全完成并且具备运行条件,可以直接在Run下运行main.py
到Run目录下:
>>>python main.py

如果运行成功你应该可以看到有4个main.py进程在


你也可以分别运行他们,依次到Api下启动ProxyApi.py,Schedule下启动ProxyRefreshSchedule.py和ProxyValidSchedule.py即可
```


　　爬虫中使用，如果要在爬虫代码中使用的话， 可以将此api封装成函数直接使用，例如:
```
import requests

def get_proxy():
    return requests.get("http://127.0.0.1:5000/get/").content

def delete_proxy(proxy):
    requests.get("http://127.0.0.1:5000/delete/?proxy={}".format(proxy))

# your spider code

def spider():
    # ....
    requests.get('https://www.example.com', proxies={"http": "http://{}".format(get_proxy())})
    # ....

```

　　测试地址：http://123.207.35.36:5000 单机勿压测。谢谢

### 6、最后
　　时间仓促，功能和代码都比较简陋，以后有时间再改进。喜欢的在github上给个star。感谢！