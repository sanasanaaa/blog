---
title: 关于egg应用结构和内置对象
---


# 关于生命周期

在应用启动阶段做的一些初始化的工作 在app.js文件中 框架提供了以下生命周期函数

- 配置文件即将加载,动态修改配置信息的最后时机 (configWillLoad)
- 配置文件加载完成 (configDidLoad)
- 文件加载完成 (didLoad)
- 插件启动完毕 (willReady)
- worker 准备就绪 (didReady)
- 应用启动完成 (serverDidReady)
- 应用即将关闭 (beforeClose)

```
// app.js
class AppBootHook {
  constructor(app) {
    this.app = app;
  }

  configWillLoad() {
    // 此时 config 文件已经被读取并合并，但是还并未生效
    // 这是应用层修改配置的最后时机
    // 注意：此函数只支持同步调用

    // 例如：参数中的密码是加密的，在此处进行解密
    this.app.config.mysql.password = decrypt(this.app.config.mysql.password);
    // 例如：插入一个中间件到框架的 coreMiddleware 之间
    const statusIdx = this.app.config.coreMiddleware.indexOf('status');
    this.app.config.coreMiddleware.splice(statusIdx + 1, 0, 'limit');
  }

  async didLoad() {
    // 所有的配置已经加载完毕
    // 可以用来加载应用自定义的文件，启动自定义的服务

    // 例如：创建自定义应用的示例
    this.app.queue = new Queue(this.app.config.queue);
    await this.app.queue.init();

    // 例如：加载自定义的目录
    this.app.loader.loadToContext(path.join(__dirname, 'app/tasks'), 'tasks', {
      fieldClass: 'tasksClasses',
    });
  }

  async willReady() {
    // 所有的插件都已启动完毕，但是应用整体还未 ready
    // 可以做一些数据初始化等操作，这些操作成功才会启动应用

    // 例如：从数据库加载数据到内存缓存
    this.app.cacheData = await this.app.model.query(QUERY_CACHE_SQL);
  }

  async didReady() {
    // 应用已经启动完毕

    const ctx = await this.app.createAnonymousContext();
    await ctx.service.Biz.request();
  }

  async serverDidReady() {
    // http / https server 已启动，开始接受外部请求
    // 此时可以从 app.server 拿到 server 的实例

    this.app.server.on('timeout', socket => {
      // handle socket timeout
    });
  }
}

module.exports = AppBootHook;
```

# 关于应用config配置
  eggjs会自动合并应用，插件，框架的配置，可根据环境维护不同的配置，合并后的配置可以从app.config里获取

1 通过修改config/env文件指定
2 通过EGG_SERVER_ENV=prod npm start

第二种方式比较常用，通过EGG_SERVER_ENV环境变量指定运行环境更加方便

与NODE_ENV的区别

很多 Node.js 应用会使用 NODE_ENV 来区分运行环境，但 EGG_SERVER_ENV 区分得更加精细。一般的项目开发流程包括本地开发环境、测试环境、生产环境等，除了本地开发环境和测试环境外，其他环境可统称为服务器环境，服务器环境的 NODE_ENV 应该为 production。而且 npm 也会使用这个变量，在应用部署的时候一般不会安装 devDependencies，所以这个值也应该为 production。

框架默认支持的运行环境及映射关系（如果未指定 EGG_SERVER_ENV 会根据 NODE_ENV 来匹配）

# 内置基础对象

## 1 Application

Application是全局应用对象，在一个应用中，只会实例化一个

### 事件

在框架运行时，会在Application实例上触发一些事件,在监听时也可在生命周期内进行监听(自定义启动脚本 app.js 生命周期内)
- server:该事件一个worker进程只会触发一次,在HTTP服务完成启动后,会将HTTP server 通过这个事件暴露出来给开发者。
- error:运行是有任何的异常被onerror插件捕获后，都触发error事件，将错误对象和关联的上下文(如果有)暴露给开发者,可以进行自定义的日志记录上报的等处理。
- request 和 response: 应用收到请求的响应请求时,分别会触发request和response事件,并将当前请求上下文暴露出来,开发者可以监听这两个事件进行日志记录。
```
// app.js

module.exports = app => {
  app.once('server', server => {
    // websocket
  });
  app.on('error', (err, ctx) => {
    // report error
  });
  app.on('request', ctx => {
    // log receive request
  });
  app.on('response', ctx => {
    // ctx.starttime is set by framework
    const used = Date.now() - ctx.starttime;
    // log total cost
  });
};
```
### 获取方式

Application对象几乎可以在任何地方获取到,几乎所有被框架 Loader 加载的文件（Controller，Service，Schedule 等），都可以 export 一个函数，这个函数会被 Loader 调用，并使用 app 作为参数：

- 启动自定义脚本 app.js
```
	//app.js
	module.exports = app =>　{

	}
```
- controller文件 this.app || this.ctx.app

- Service文件中 thia.app

## Context

 在每一次收到用户请求时，框架会实例化一个 Context 对象，这个对象封装了这次用户请求的信息，并提供了许多便捷的方法来获取请求参数或者设置响应信息。框架会将所有的 Service 挂载到 Context 实例上，一些插件也会将一些其他的方法和对象挂载到它上面（egg-sequelize 会将所有的 model 挂载在 Context 上）。

### 获取方式

最常见的 Context 实例获取方式是在 Middleware, Controller 以及 Service 中。框架的Middleware 可以直接用this 或者ctx获取context

```
// Koa v1
function* middleware(next) {
  // this is instance of Context
  console.log(this.query);
  yield next;
}

// Koa v2
async function middleware(ctx, next) {
  // ctx is instance of Context
  console.log(ctx.query);
}
```
除了在请求时可以获取 Context 实例之外， 在有些非用户请求的场景下我们需要访问 service / model 等 Context 实例上的对象，我们可以通过 Application.createAnonymousContext() 方法创建一个匿名 Context 实例：
```
// app.js
module.exports = app => {
  app.beforeStart(async () => {
    const ctx = app.createAnonymousContext();
    // preload before app start
    await ctx.service.posts.load();
  });
}
```
在定时任务中的每一个 task 都接受一个 Context 实例作为参数，以便我们更方便的执行一些定时的业务逻辑：
```
// app/schedule/refresh.js
exports.task = async ctx => {
  await ctx.service.posts.refresh();
};
```
## Request & Response

可以在Context实例上获取当前的Request和Response实例

ctx.query和ctx.request.query是等价的，但是ctx.body = ctx.response.body 而不是ctx.request.body

## Controller
框架提供一个Controller基类，这个基类包含的属性有：ctx app config service logger

基类的引入有两个方式
```
1 const Controller = require("egg").Controller
  class XXXController extends Controller{

  }
  module.exports=XXXController;
---------------------------------------------------
2 module.exports = (app) => {
	 return class XXXController extends app.Controller{

	 };
  }
```
## Service
框架提供了一个 Service 基类，并推荐所有的 Service 都继承于该基类实现。
Service 基类的属性和 Controller 基类属性一致，访问方式也类似：
```
// app/service/user.js

// 从 egg 上获取（推荐）
const Service = require('egg').Service;
class UserService extends Service {
  // implement
}
module.exports = UserService;

// 从 app 实例上获取
module.exports = app => {
  return class UserService extends app.Service {
    // implement
  };
};
```
## Helper
Helper 用来提供一些实用的 utility 函数。它的作用在于我们可以将一些常用的动作抽离在 helper.js 里面成为一个独立的函数，这样可以用 JavaScript 来写复杂的逻辑，避免逻辑分散各处，同时可以更好的编写测试用例。

Helper 自身是一个类，有和 Controller 基类一样的属性，它也会在每次请求时进行实例化，因此 Helper 上的所有函数也能获取到当前请求相关的上下文信息。

获取方式
可以在 Context 的实例上获取到当前请求的 Helper(ctx.helper) 实例。
```
// app/controller/user.js
class UserController extends Controller {
  async fetch() {
    const { app, ctx } = this;
    const id = ctx.query.id;
    const user = app.cache.get(id);
    ctx.body = ctx.helper.formatUser(user);
  }
}
```
除此之外，Helper 的实例还可以在模板中获取到，例如可以在模板中获取到 security 插件提供的 shtml 方法。
```
// app/view/home.nj
{{ helper.shtml(value) }}
```
自定义 helper 方法
应用开发中，我们可能经常要自定义一些 helper 方法，例如上面例子中的 formatUser，我们可以通过框架扩展的形式来自定义 helper 方法。
```
// app/extend/helper.js
module.exports = {
  formatUser(user) {
    return only(user, [ 'name', 'phone' ]);
  }
};
```
## Config
我们推荐应用开发遵循配置和代码分离的原则，将一些需要硬编码的业务配置都放到配置文件中，同时配置文件支持各个不同的运行环境使用不同的配置，使用起来也非常方便，所有框架、插件和应用级别的配置都可以通过 Config 对象获取到，关于框架的配置，可以详细阅读 Config 配置章节。

获取方式
我们可以通过 app.config 从 Application 实例上获取到 config 对象，也可以在 Controller, Service, Helper 的实例上通过 this.config 获取到 config 对象。

## Logger
框架内置了功能强大的日志功能，可以非常方便的打印各种级别的日志到对应的日志文件中，每一个 logger 对象都提供了 4 个级别的方法：

- logger.debug()
- logger.info()
- logger.warn()
- logger.error()
在框架中提供了多个 Logger 对象，下面我们简单的介绍一下各个 Logger 对象的获取方式和使用场景。

App Logger
我们可以通过 app.logger 来获取到它，如果我们想做一些应用级别的日志记