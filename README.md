# bash-简化

##  xxx

```shell
#在当前bash脚本中导入dir_util.sh中的函数和变量
#如果你本地没有本仓库，则可以用直接用本仓库文件的url
source <(curl -s  http://giteaz:3000/bal/bash-simplify/raw/branch/bal/dev/dir_util.sh)
#  '<()' 叫做linux中的进程替换

#若果你已经有本仓库，那么可以直接用文件路径
#source /bal/bash-simplify/dir_util.sh

#使用dir_util.sh中的函数 getCurScriptDirName 获得 当前脚本所在的目录 的绝对路径，  不依赖于工作目录在哪里
getCurScriptDirName $0
#进入当前脚本所在目录
cd $CurScriptDir && \

```

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


#省略 函数_is_git_2x 、_install_git_2x ，  其内容请参考 https://gitcode.net/bal/bash-simplify/-/blob/master/example.sh


#以下 写法 即为 简化后的 bash 的 ifelse 语法样式:
{ \
ifelse  $CurScriptF $LINENO || true || { \  #'true ||' 是为了 整体上 短路 下面6个参数行 (本行不能有注释)
  _is_git_2x
    "git版本无需升级,已为2.x:$curGitVer"
    : 
  #else:
    _install_git_2x
      "安装git2x完成" 
} \
} && \



```
>   赋值样式 _="消息" 是一个合法的bash语句，  而  值样式 "消息" 不是合法bash语句。


> 注意， bash中 ':' 表示 空命令

###  解释:
- ```{ \```   
> 业务代码块 开始

- ```ifelse  $CurScriptF $LINENO || true || { \```  
> 固定写法,  脚本example.sh的31行的 ifelse调用 翻译出来 意思是 ifelse example.sh 31


- ```  cmdA1 ```                      
- ```    "$msgCmdA1Good"  ```            
- ```    cmdA2 ```                       
- ```  #else：  ```                                 
- ```    cmdB1 ```                     
- ```      "$msgCmdB1Good" ```         

```python
if cmdA1执行正常:
   echo $msgCmdA1Good
   执行cmdA2
else: #即cmdA1执行异常
   if cmdB1执行正常:
      echo $msgCmdB1Good
```


- ```} \```  
> 参数行结束

- ```} && \```  
> 业务代码块结束



### ifelse写法的好处： 
1. 简化了if-else
2. 业务代码可读性高 (业务代码不需要放进""中, 可以让IDE充分检查业务代码 )

### ifelse 如何做到 将 业务代码 不放进 "" 中 却 还能动态调用业务代码？
> 答:
- eval '业务代码' , 这是bash给的能力，无法改变
- ifelse函数调用处 ```ifelse  $CurScriptF $LINENO```  后的6行 也是 正常的bash脚本 ， 但这6行脚本整体上 都前缀'true ||' 短路了，相当于这6行根本没有执行
>>  由于这6行也是正常的bash脚本，而 这6行 即为 业务代码， 即 业务代码 不用 放进 "" 中
- ifelse内部 主动读取这6行业务代码，并将相关前缀、后缀摘除后， 通过 【 eval '业务代码' 】  来执行业务代码
>>  即 业务代码 在 执行时 ， 还是 被 放进 "" 中了。

>>  前缀 即 'true ||' 


## 注意
- ifelse目前的样式 无法写出 ifelse嵌套, 

- 因 bash 没有局部变量的概念， 因此 应该 避免 bash函数嵌套. 故而， 即使 改造了 ifelse 使其 支持嵌套， 也应该避免 嵌套。
 
>> 对于 bash 局部变量 有: 函数内定义的变量，函数外一样能访问和修改； 同样 ，   函数外定义的变量，函数内一样能访问和修改。

# 说明
> 此例子来自文件：[example.sh](https://gitcode.net/bal/bash-simplify/-/blob/master/example.sh)
