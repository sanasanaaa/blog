---
title: hexo github 搭建个人博客
tags: hexo
categories: hexo
top: 1
---

# 安装node git

	安装过程略
	查看是否安装成功 
	git version 
	node -v
	npm -v

# 安装 Hexo
在准备好后,开始使用npm 安装 Hexo 

	npm install -g hexo-cli

安装Hexo后,新建Hexo项目,并安装依赖

	hexo init myblog
	cd myblog
	npm install

新建完成后 文件夹目录:

	├── _config.yml # 网站的配置信息。 
	├── package.json
	├── scaffolds # 模版文件夹
	├── source  # 资源文件夹，除 _posts 文件，其他以下划线_开头的文件或者文件夹不会被编译打包到public文件夹
	|   ├── _drafts # 草稿文件
	|   └── _posts # 文章Markdowm文件 
	└── themes  # 主题文件夹
运行 hexo server 或者 hexo s 启动 然后在 http://localhost:4000 查看效果

# github 静态地址
首先 Github 每个用户只能使用一个同名仓库来托管一个静态站点

	先创建一个新的仓库 仓库名必须是 用户名.github.io

## github部署
1 首先在项目根目录下的_config.yml配置文件配置参数 添加如下

	deploy:
		type:git
		repo:
			github:https://github,com/sanxiansheng/sanxiansheng.github.io.git
		branch:master

2 安装部署插件 hexo-deployer-git --save

	npm install hexo-deployer-git --save

3 执行部署
	
	hexo clean 清除缓存文件(db.json)和已生成的静态文件
	hexo g -d

# 绑定域名

在万网注册，在控制台找到购买的域名点，右侧的解析按钮进去解析列表
点右边的“添加记录”添加两条 CNAME 类型的记录，记录值为github地址

记录添加完后就要到 Github 设置绑定域名,博客仓库点 Setting,GitHub Pages 保存自己的域名，有时候不能save，也可以在 用户名.github.io 的仓库根目录/source 目录下手动创建一个 CNAME 文件，内容为自己的域名地址，然后再去绑定就可以了
