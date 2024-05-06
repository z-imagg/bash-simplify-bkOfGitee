#!/usr/bin/python3

#【描述】   python解析url输出json结果
#【依赖】   
#【术语】  
#【备注】   


def Url2Json(encoded_url:str):
    import typing
    import json
    from urllib3.util.url import parse_url,Url
    from urllib.parse import unquote
    #解码url
    u:Url = parse_url(encoded_url)
    dct:typing.Dict[str,str]=u._asdict()
    jsnTxt:str=json.dumps( dct )
    print(jsnTxt)


import sys
# sys.argv.append("https://github.com/xxx/yyy.html?arg1=v1&arg2=v2#p1")
if len(sys.argv)!=2:
    print("usage:me.py url",file=sys.stderr)
    exit(1)
#只有一个参数为url
encoded_url:str = sys.argv[1]
Url2Json(encoded_url)

#使用举例
#安装依赖
#  sudo apt install -y jq
# 一般例子
#  python /app/bash-simplify/Url2Json.py "https://github.com/xxx/yyy.html?arg1=v1&arg2=v2#p1"
#   {"scheme": "https", "auth": null, "host": "github.com", "port": null, "path": "/xxx/yyy.html", "query": "arg1=v1&arg2=v2", "fragment": "p1"}
# 解析正常例子
#                                                               第一次解析确认是否为合法url                   若合法url 则再次解析获得结果
#  url="https://github.com/xxx/yyy.html?arg1=v1&arg2=v2#p1" ; python /app/bash-simplify/Url2Json.py "$url" && python /app/bash-simplify/Url2Json.py "$url" | jq   .host
#   输出 "github.com"
# 解析错误例子
#  url="::xxx" ; python /app/bash-simplify/Url2Json.py "$url" && python /app/bash-simplify/Url2Json.py "$url" | jq   .host
#   输出 "github.com"

