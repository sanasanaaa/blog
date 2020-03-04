---
title: html元素 css选择器 css定位
categories: css
---

# 标签
1 块级元素 占据其父元素(容器)的整个空间 ，因此创建一个'块'

	<h1> <h2> <h3> <h4> <h5> <h6> 标题级别 1-6
	<div>  
	<form> 表单 <table> 表格
	<hr> 水平分隔线
	<ol> 有序列表
	<ul> 无序列表
	<li>
	<p> 段落

2 行内元素

	<b> <i> <a> <img> <span> <sub> <sup> <strong> <em>

	<input> <button> <label> <select> <textarea>

# css选择器
## 1基本选择器 

	.calss  类选择器
	#id     id选择器
	*       通用选择器
	element 元素选择器

## 2组合选择器

	E F			后代选择器
	E>F			直接子代选择器
	E+F			相邻元素选择器
	E~F			兄弟元素选择器

## 3属性选择器

	E[att]	选择具有att属性的E元素
	E[att="val"]	选择具有att属性且属性值等于val的E元素
	E[att~="val"]	选择具有att属性且属性值其中一个等于val的E元素（包含只有一个值且该值等于val的情况）
	E[att|="val"]	选择具有att属性且属性值为以val开头并用连接符-分隔的字符串的E元素，如果属性值仅为val，也将被选择
	E[att^="val"]	选择具有att属性且属性值为以val开头的字符串的E元素
	E[att$="val"]	选择具有att属性且属性值为以val结尾的字符串的E元素
	E[att*="val"]	选择具有att属性且属性值为包含val的字符串的E元素

## 4伪类选择器

	:link	  a:link	选择所有未访问链接	
	:visited	a:visited	选择所有访问过的链接	
	:hover	a:hover	把鼠标放在链接上的状态	
	:active	a:active	选择正在活动链接	
	:focus	input:focus	选择元素输入后具有焦点

## 5伪元素选择器

	::before/:before	在被选元素前插入内容。	需要使用 content 属性来指定要插入的内容。被插入的内容实际上不在文档树中。	
	::after/:after	在选被元素后插入内容	其用法和特性与:before相似。	
	::first-letter/:first-letter	匹配元素中文本的首字母。	被修饰的首字母不在文档树中。	
	::first-line/:first-line	匹配元素中第一行的文本。	这个伪元素只能用在块元素中，不能用在内联元素中。

## 6其他
**关于:not()的用法**
假定有个列表，每个列表项都有一条底边线，但是最后一项不需要底边线。
 	li:not(:last-child) {
    	border-bottom: 1px solid #ddd;
	}
上述代码的意思是：给该列表中除最后一项外的所有列表项加一条底边线。是不是很方便。

**关于:nth-child()的用法**
要使E:nth-child(n)生效，E元素必须是某个元素的子元素，E的父元素最高是body，即E可以是body的子元素。:first-child、:last-child、:only-child、:nth-last-child(n)也是一样。
nth-child(n)括号里的n可以是一个数字，一个关键字，或者一个公式。
:nth-child(length) /*参数是具体数字 length为整数*/
:nth-child(n) /*参数是n,n从0开始计算*/
:nth-child(n*length) /*n的倍数选择，n从0开始算*/
:nth-child(n+length) /*选择大于等于length后面的元素*/
:nth-child(-n+length) /*选择小于等于length前面的元素*/
:nth-child(n*length+1) /*表示隔几选一*/
:nth-child(2n) / :nth-child(even) /*表示偶数*/
:nth-child(2n+1) / :nth-child(odd) /*表示奇数*/

**关于:...-child和:...-of-type的差异**
这两个系列的属性确实很相似，对于不熟悉的人可能很难区分。
E:first-of-type 总是能命中父元素的第1个为E的子元素，不论父元素第1个子元素是否为E；而E:first-child里的E元素必须是它的兄弟元素中的第一个元素，否则匹配失效。E:last-of-type 与E:last-child也是同理。
E:nth-of-type(n)总是能命中父元素的第n个为E的子元素，不论父元素第n个子元素是否为E；而E:nth-child(n)会选择父元素的第n个子元素E，如果第n个子元素不是E，则是无效选择符，但n会递增。
关于:nth-child()与:nth-of-type()的区别可以看这篇文章

**用:empty区分空元素**
选择不包含子元素的div元素：

	div:empty
选择包含子元素的div元素：

	div:not(:empty)
# 定位
**文档流** 
html文档流 元素是按照在html中的位置顺序进行排布的 (float 和绝对定位 会脱离文档流)

## static 默认

	position:static

定位的默认值，始终处于文档流中的位置

## fixed  固定

	position:fixed

相对于浏览器窗口指定位置 ps:当祖先元素中有transform 属性时，fixed不再会相对于浏览器窗口定位

## relative 相对定位

	position:relative

相对于该元素在文档中的初始位置进行定位 通过 left top right bottom 来设置元素相对于自身位置进行偏移

## absolute 绝对定位

	position:absolute

相对于最近的已定位的祖先元素进行定位，如果没有，那就相对于左上角进行定位


  


