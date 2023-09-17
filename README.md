- [1 基础](#1-基础)
- [1.1 关闭代码执行输出,否则每一行都会替换结果后输出](#11-关闭代码执行输出否则每一行都会替换结果后输出)
- [1.2 goto, 用冒号开头标识一个起点,使用goto语句跳转到flag位置执行](#12-goto-用冒号开头标识一个起点使用goto语句跳转到flag位置执行)
- [1.3 注释的两种方法](#13-注释的两种方法)
- [1.4 变量声明](#14-变量声明)
- [1.5 延迟解析, 动态替换](#15-延迟解析-动态替换)
- [1.7 常用命令对比](#17-常用命令对比)
- [1.8 for循环](#18-for循环)
- [1.8.1 遍历一组数字](#181-遍历一组数字)
- [1.8.2 遍历一组字符串](#182-遍历一组字符串)
- [1.8.3 遍历文件](#183-遍历文件)
- [1.8.3 遍历文件夹](#183-遍历文件夹)
- [1.8.4 遍历命令的输出](#184-遍历命令的输出)
- [1.8.5 for /f 使用实例](#185-for-f-使用实例)
- [1.9 字符串操作](#19-字符串操作)
- [2 代码实例](#2-代码实例)

# 1 基础

# 1.1 关闭代码执行输出,否则每一行都会替换结果后输出
```bat
@echo off

```
# 1.2 goto, 用冒号开头标识一个起点,使用goto语句跳转到flag位置执行
```bat
:flag
goto flag
```

# 1.3 注释的两种方法
```bat
@rem hello
::hello
```

# 1.4 变量声明
```bat
@rem 以下三种方式都可以, 不过需要注意类型
set "result=111"
set result=111
set result="111"

@rem 设置为空变量
set "result="
set result=""

@rem 字符串拼接
@rem 1.这种方式输出的 "111"222
set result="111"
set "result1=%result%222" 
@rem 2.这种方式输出的 111222
set result=111
set "result1=%result%222"
@rem 3.使用 %, 输入为 Hello World
set str1=Hello
set str2=World
set result1=%str1% %str2%

```
# 1.5 延迟解析, 动态替换

输出结果为
Hello
Hello
Hello
for循环中设置的不生效
```bat
@echo off
set var=Hello

for %%a in (1 2 3) do (
    set var=World
    echo %var%
)

echo %var%
```

开启延迟扩展, 注意%要换成!
```bat
@echo off
setlocal enabledelayedexpansion

set var=Hello

for %%a in (1 2 3) do (
    set var=World
    echo !var!
)

echo !var!
endlocal
```

# 1.7 常用命令对比
| Windows命令行 | 功能描述 | Linux终端 |
| --- | --- | --- |
| cd | 切换工作目录 | cd |
| dir | 列出当前文件夹下所有文件 | ls [-lh] |
| type | 查看文件内容 | cat |
| md/mkdir | 创建目录 | mkdir |
| del | 删除文件 | rm |
| rd | 删除目录 | rm -r |
| copy/xcopy | 拷贝 | cp [-r] |
| cls | 清屏 | clear |
| findstr | 根据关键字查找 | grep |
| move/rename | 移动/重命名 | mv/rename |
| tasklist | 查找进程 | ps [-ef] |
| taskkill | 杀死进程 | kill [-9] |


# 1.8 for循环

# 1.8.1 遍历一组数字
```bat
@echo off
@rem 输出1,2,3,4,5
for /l %%i in (1, 1, 5) do (
    echo %%i
)
@rem 输出1,1,5, 注意这里加不加逗号没区别, 因为逗号和空格等效
for %%i in (1, 1, 5) do (
    echo %%i
)
```
在这个例子中，/l参数表示这是一个数字范围，(1, 1, 5)表示从1开始，每次增加1，直到5。%%i是一个变量，它的值会在每次循环时被设置为当前的数字。

# 1.8.2 遍历一组字符串
同上
```bat
@echo off
for %%i in (A B C D E) do echo %%i
```
在这个例子中，for循环会遍历括号中的每个字符串，并在每次循环时将%%i设置为当前的字符串。

# 1.8.3 遍历文件
可以指定目录,相对路径(d:\test\*.txt)和绝对路径(test\*.txt)都行

```bat
@echo off
@rem 只遍历单层目录
for %%i in (*.txt) do echo %%i

@rem 只遍历目录及其子目录, 注意打印的绝对路径
for /R %%i in (*.txt) do echo %%i
```
在这个例子中，for循环会遍历当前目录下的所有.txt文件，并在每次循环时将%%i设置为当前的文件名。

# 1.8.3 遍历文件夹

```bat
@echo off
@rem 只遍历单层目录
for /d %%i in (*) do echo %%i

@rem 只遍历目录及其子目录
for /d /R %%i in (*) do echo %%i
```
在这个例子中，/d参数表示这是一个目录，for循环会遍历当前目录下的所有子目录，并在每次循环时将%%i设置为当前的目录名。

# 1.8.4 遍历命令的输出

```bat
@echo off
for /f "tokens=*" %%i in ('dir /b') do echo %%i
```
在这个例子中，/f参数表示这是一个文件或命令的输出，"tokens=*"表示将每行的所有内容作为一个整体处理，'dir /b'是一个命令，它会列出当前目录下的所有文件和目录。for循环会遍历这个命令的输出，并在每次循环时将%%i设置为当前的行。

# 1.8.5 for /f 使用实例
text.txt内容如下

```txt
111,aaa,AAA
222,bbb,BBB
333,ccc,CCC
```

```bat
@echo off
@rem 按照逗号分割, 注意delims和token之间要有一个空格
for /f "delims=, tokens=1,2 " %%a in (test.txt) do (
    echo %%a %%b
)

@rem 分割一次
for /f "delims=, tokens=1,*" %%a in (test.txt) do (
    echo %%a %%b
)
```
for /f命令在Windows批处理脚本中用于处理文件、命令的输出或字符串。除了delims和tokens参数，它还支持以下参数：

- eol：定义行结束字符，通常用于指定注释字符。例如，eol=#将会忽略以#开头的行。

- skip：跳过指定数量的行。例如，skip=2将会跳过前两行。

- usebackq：改变处理文件名、命令字符串和数据字符串的方式。默认情况下，双引号用于文件名，单引号用于命令字符串，无引号用于数据字符串。使用usebackq后，反引号用于文件名，双引号用于命令字符串，单引号用于数据字符串。

这些参数可以组合使用，例如：

```bat
for /f "eol=# tokens=1,2 delims=, skip=2 usebackq" %%a in ("test.txt") do (
    echo %%a
    echo %%b
)
```
这个命令将会跳过test.txt文件的前两行，忽略以#开头的行，然后按照逗号分割每一行，并打印出分割后的第一部分和第二部分。

# 1.9 字符串操作
你可以使用%variable:~start,length%语法来截取字符串。这里的start是开始位置（从0开始），length是截取的长度。

例如，假设你有一个变量str，其值为Hello, World!，你可以使用以下命令来截取并打印出str的前5个字符：

```bat
set str=Hello, World!
echo %str:~0,5%
```
这将会输出Hello。

如果你想从特定位置开始截取到字符串的末尾，你可以省略length参数。例如，以下命令将会截取并打印出str从第7个字符开始到末尾的部分：

```bat
echo %str:~7%
```
这将会输出World!。

注意，这种截取方式是从0开始计数的，所以str:~7实际上是从str的第8个字符开始截取的。

# 2 代码实例