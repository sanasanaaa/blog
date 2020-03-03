---
title: One.Markdown 写文章的一些语法总结
tags: 
	markdown
categories:
	other
top: 1
---
 #  Markdown 标题
 markdown标题有两种写法：

 ## 使用=和-标记一级二级标题

``` bash
	格式如下：
	一级标题
	=======

	二级标题
	-------
```
##  使用#标记
使用#可表示1-6级标题 
```bash
	# 一级标题
	## 二级标题
	### 三级标题
	#### 四级标题
	##### 五级标题
	###### 六级标题
```
# Markdown 段落&格式
## 段落
Markdown 段落没有特殊的格式,直接编写文字就好了,段落的换行是使用两个以上空格加上回车。
```bash
	Don't move that stumbling block &nbsp;&nbsp;&enter;
	Don't move that stumbling block
```

也可以在段落后面使用一个空行来表示重新开始一个段落
```bash
	Don't move that stumbling block 

	Don't move that stumbling block
```
## 字体
Markdown可以使用以下几种字体
```
	 *斜体文本*
	 _斜体文本_
	 **粗体文本**
	 __粗体文本__
	 ***粗斜体文本***
	 ___粗斜体文本___
```
## 分隔线
使用三个以上的星号、减号，底线来建立一个分隔线，行内不能有有其他东西
```
***
******
---
------
___
______
```
## 删除线
在文字的两端加上两个~~即可
```
	~~Don't move that stumbling block~~
```
## 下划线
下划线可以使用HTML的&lt;u&gt;标签实现
```
	<u>Don't move </u> that stumbling block
```
<u>Don't move </u>  that stumbling block

# Markdown列表
Markdown 支持有序列表和无序列表。无序列表使用星号(*)、加号(+)或是减号(-)作为列表标记;
```
* 第一项 
* 第二项 
* 第三项
+ 第三项 
+ 第二项 
+ 第三项
- 第一项 
- 第二项 
- 第三项
```
* 第一项  
* 第二项  
* 第三项
+ 第三项 
+ 第二项 
+ 第三项
- 第一项 
- 第二项 
- 第三项

有序列表使用数字并加上 .号来表示，如:
```
1.第一项
2.第二项
3.第三项
```
1. 第一项
2. 第二项
3. 第三项
## 列表嵌套
列表嵌套只需在自列表中的选项添加四个空格即可
```
1. 第一项:
    - 第一项的第一个元素
	- 第一项的第二个元素
2. 第二项:
    - 第二项的第一个元素
	- 第二项的第二个元素
```
 1. 第一项:
    - 第一项的第一个元素
	- 第一项的第二个元素
 2. 第二项:
    - 第二项的第一个元素
	- 第二项的第二个元素

# Markdown区块
Markdown区块引用是在段落开头使用 > 符号，然后后面紧跟一个空格符号
```
> Don't move that stumbling block
```
> Don't move that stumbling block
另外区块是可以嵌套的,一个>符号是第一层嵌套，以此类推
```
> 最外层
>> 第一层嵌套
>>> 第二层嵌套
```
> 最外层
>> 第一层嵌套
>>> 第二层嵌套
区块中使用列表
```
> 区块中使用列表
> 1. 第一项
> 2. 第二项
> + 第一项
> + 第二项
> + 第三项
```
> 区块中使用列表
> 1. 第一项
> 2. 第二项
> + 第一项
> + 第二项
> + 第三项

列表中使用区块
如果要在列表项目内放进区块,那么就需要在> 前添加四个空格的缩进。
```
* 第一项
    > Don't move that stumbling block
	> Don't move that stumbling block
* 第二项
```
* 第一项
    > Don't move that stumbling block
	> Don't move that stumbling block
* 第二项

# Markdown 代码
如果是段落上的一个函数或者片段的代码可以用反引号把它包起来 `
	
	`print()` 函数

`print()` 函数

## 代码区块
代码区块使用4个空格或者一个制表符(Tab键) 前需要空一行
	
	Don't move that stumbling block
也可用 三个` 包裹一段代码，还可以指定之种语言



```javascript
function person(){
			
}
```
# Markdown 链接
链接使用方法如下:
```
 [链接名称](链接地址) 或者 <链接地址>
```
 链接 [百度](http://www.baidu.com)

<https://www.baidu.com>

##高级链接
```
链接也可以用变量来代替，文档末尾附带变量地址：
这个链接用 1 作为网址变量 [Google][1]
这个链接用 runoob 作为网址变量 [Runoob][runoob]
然后在文档的结尾为变量赋值（网址）

  [1]: http://www.google.com/
  [sanasan]: http://sanasan.top
```
链接也可以用变量来代替，文档末尾附带变量地址：
这个链接用 1 作为网址变量 [Google][1]
这个链接用 runoob 作为网址变量 [sanasan][sanasan]
然后在文档的结尾为变量赋值（网址）

  [1]: http://www.google.com/
  [sanasan]: http://sanasan.top

# Markdown 图片
Markdown 图片语法格式:
```
![alt 属性文本](图片地址)
![alt 属性文本](图片地址 "可选标题") 
<img src="http://sanasan.top/images/myphoto.jpg">
```
！[myself](http://sanasan.top/images/myphoto.jpg)
 <img src="http://sanasan.top/images/myphoto.jpg" width:50%>

# Markdown 表格
Markdown 制作表格使用 | 来分隔不同的单元格,使用 - 来分隔表头和其他行.

```
|  表头   | 表头  |
|  ----  | ----  |
| 单元格  | 单元格 |
| 单元格  | 单元格 |
```
|  表头   | 表头  |
|  ----  | ----  |
| 单元格  | 单元格 |
| 单元格  | 单元格 |

设置表格的对齐方式
- -: 设置内容和标题栏居右对齐。
- :- 设置内容和标题栏居左对齐。
- :-: 设置内容和标题栏居中对齐。

```
| 左对齐 | 右对齐 | 居中对齐 |
| :-----| ----:  | :----: |
| 1     |   1    |   1     |
| 1     |   1    |   1     |

```

| 左对齐 | 右对齐 | 居中对齐 |
| :-   | -:      |    :-:      |
| 1     |   1    |   1     |
| 1     |   1    |   1     |

# Markdown 高级技巧
## 支持的HTML元素
不在Markdown涵盖范围之内的标签，都可以直接在文档里用HTML撰写。
目前支持的HTML元素有: `<kdb> <b> <i> <em> <sup> <sub> <br>`

## 转义
Markdown 使用了很多特殊符号来表示特定的意义,如果需要显示特定的符号则需要使用转义字符，Markdown 使用反斜杠转义特殊字符 

 `\*` \* 显示正常的星号

