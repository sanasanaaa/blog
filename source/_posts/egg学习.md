---
title: egg学习 项目结构
tags: 
	eggjs
top: 1
---

<img src="http://sanasan.top/images/egg.png">

绿色虚线框中的所有组件组成了一个Worker，这就是egg.js中实际执行代码逻辑的进程，是一个node服务器。

 - request进来后，先穿过中间件，自己定义的中间件都放在projectDir/app/middleware下，并在config中启用。
 - egg.js内置了egg-static中间件，将静态资源放在projectDir/app/public中，只会经过egg-static中间件之前的中间件，最后egg-static直接响应给客户端，不会到达其后的中间件以及Router。
 - 如果不是public中的资源，将会穿越所有中间件，到达路由。一般所有的路由都放在router.js中，这个文件没有任何逻辑，而是直接指向一个处理请求的controller，只起到目录和索引的作用:
```
egg-project
├── package.json
├── app.js (可选)
├── agent.js (可选)
├── app
|   ├── router.js
│   ├── controller
│   |   └── home.js
│   ├── service (可选)
│   |   └── user.js
│   ├── middleware (可选)
│   |   └── response_time.js
│   ├── schedule (可选)
│   |   └── my_task.js
│   ├── public (可选)
│   |   └── reset.css
│   ├── view (可选)
│   |   └── home.tpl
│   └── extend (可选)
│       ├── helper.js (可选)
│       ├── request.js (可选)
│       ├── response.js (可选)
│       ├── context.js (可选)
│       ├── application.js (可选)
│       └── agent.js (可选)
├── config
|   ├── plugin.js
|   ├── config.default.js
│   ├── config.prod.js
|   ├── config.test.js (可选)
|   ├── config.local.js (可选)
|   └── config.unittest.js (可选)
└── test
    ├── middleware
    |   └── response_time.test.js
    └── controller
        └── home.test.js
```


如上，由框架约定的目录：

- app/router.js 用于配置 URL 路由规则，具体参见 Router。
- app/controller/** 用于解析用户的输入，处理后返回相应的结果，具体参见 Controller。
- app/service/** 用于编写业务逻辑层，可选，建议使用，具体参见 Service。
- app/middleware/** 用于编写中间件，可选，具体参见 Middleware。
- app/public/** 用于放置静态资源，可选，具体参见内置插件 egg-static。
- app/extend/** 用于框架的扩展，可选，具体参见框架扩展。
- config/config.{env}.js 用于编写配置文件，具体参见配置。
- config/plugin.js 用于配置需要加载的插件，具体参见插件。
- test/** 用于单元测试，具体参见单元测试。
- app.js 和 agent.js 用于自定义启动时的初始化工作，可选，具体参见启动自定义。关于agent.js的作用参见Agent机制。
由内置插件约定的目录：

- app/public/** 用于放置静态资源，可选，具体参见内置插件 egg-static。
- app/schedule/** 用于定时任务，可选，具体参见定时任务。

若需自定义自己的目录规范，参见 Loader API

- app/view/** 用于放置模板文件，可选，由模板插件约定，具体参见模板渲染。
- app/model/** 用于放置领域模型，可选，由领域类相关插件约定，如 egg-sequelize。