# bash-简化

## 简化的 ifelse语法

###  准备:
```shell
#!/bin/bash

#加载 func.sh中的函数 ifelse
source func.sh

#当前脚本文件名, 此处 CurScriptF=example.sh
CurScriptF=$0

```

###  业务代码:
> 业务内容: 升级git到2.x版本


```shell


#省略 函数_is_git_2x 、_install_git_2x ，  其内容请参考 https://gitcode.net/crk/bash-simplify/-/blob/master/example.sh


#以下 写法 即为 简化后的 bash 的 ifelse 语法样式:
ifelse  $CurScriptF $LINENO
  true || _is_git_2x && \
    true || "git版本无需升级,已为2.x" && \
    true || : && \
  #else:
    true || _install_git_2x && \
      true || "" && \




```
> 注意， bash中 ':' 表示 空命令

###  解释:
- ```ifelse  $CurScriptF $LINENO```  
> 固定写法,  脚本example.sh的31行的 ifelse调用 翻译出来 意思是 ifelse example.sh 31


- ```  true || cmdA1 && \ ```                      
- ```    true || "$msgCmdA1Good" && \  ```            
- ```    true || cmdA2 && \ ```                       
- ```  #else：  ```                                 
- ```    true || cmdB1 && \ ```                     
- ```      true || "$msgCmdB1Good" && \ ```         


```python
if cmdA1执行正常:
   echo $msgCmdA1Good
   执行cmdA2
else: #即cmdA1执行异常
   if cmdB1执行正常:
      echo $msgCmdB1Good
```

### ifelse写法的好处： 
1. 简化了if-else
2. 业务代码可读性高 (业务代码不需要放进""中, 可以让IDE充分检查业务代码 )

### ifelse 如何做到 将 业务代码 不放进 "" 中 却 还能动态调用业务代码？
> 答:
- eval '业务代码' , 这是bash给的能力，无法改变
- ifelse函数调用处 ```ifelse  $CurScriptF $LINENO```  后的6行 也是 正常的bash脚本 ， 但这6行脚本 都被前缀'true ||' 短路了，相当于这6行根本没有执行
>>  由于这6行也是正常的bash脚本，而 这6行 即为 业务代码， 即 业务代码 不用 放进 "" 中
- ifelse内部 主动读取这6行业务代码，并将相关前缀、后缀摘除后， 通过 【 eval '业务代码' 】  来执行业务代码
>>  即 业务代码 在 执行时 ， 还是 被 放进 "" 中了。

>>  前缀 即 'true ||', 后缀 即 '&& \'  


# 说明
> 此例子来自文件：[example.sh](https://gitcode.net/crk/bash-simplify/-/blob/master/example.sh)
