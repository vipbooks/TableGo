# TableGo

#### 介绍

![](http://cdn.tablego.cn/images/tablego.png)

　　TableGo是基于数据库的自动化生成工具，低代码编程技术的实现，全能代码生成器，自动生成项目框架、生成JavaBean、生成前后端代码、生成数据库文档、生成API文档、自动化部署项目、能查出数据库数据生成各种代码和文档等，更重要的是可以根据每个项目的不同开发框架编写自定义模板与项目框架适配生成各模块增删查改的前后端代码，让开发人员的开发效率提高60%以上，还可以通过模板定义开发规范统一开发风格和标准，提高代码的规范性和可维护性。<br/>
　　只要设计好数据库并且添加好备注，就能通过自定义模板生成任意编程语言的任何程序代码，并且能够生成各种代码备注。实现只要把数据数据库设计好，整个项目就完成了很大一部分代码的编写，极大的节省了项目的开发成本。支持MySQL、Oracle、SQL Server、PostgreSQL、MariaDB、DB2 六种数据库，支持Window、Linux、Mac OS等多种操作系统。<br/>
　　TableGo原生不支持的数据库可以通过配置自定义扩展数据库获得支持，可通过配置database.ini配置文件让TableGo支持更多关系型数据库，在新的database.ini配置文件已经包含对武汉达梦、人大金仓V8、神舟通用、南大通用等四种数据库的扩展支持配置。<br/>
　　TableGo还可以通过服务器接连终端功能使用SSH2连接Linux服务器，实现命令执行、上传下载文件、按指定顺序自动执行各种命令和操作，实现一键更新打包上传自动化部署前后端项目工程到DEV、TEST、SIT、UAT环境，支持自动备份、自动清理备份、自动还原备份等功能，并且支持常规部署和Docker容器部署。<br/>
　　使用自定义模板功能可以根据数据库表结构信息生成你想要的任何代码，例如：Java、C#、C++、Golang、Rust、Python、Objective-C、Swift、Kotlin、VB、VC、SQL、HTML、JSP、JS、PHP、Vue、React、Word、Excel等等，没有做不到只有想不到……<br/>
　　可以生成Java、C#、C++、Golang、Rust、Python、Objective-C、Swift、iOS等各种不同平台编程语言的数据模型或结构体，对应的自定义模板示例已提供。<br/><br/>
　　TableGo官网：[http://www.tablego.cn](http://www.tablego.cn)<br/>
　　发行版下载：[https://github.com/vipbooks/TableGo/releases](https://github.com/vipbooks/TableGo/releases)<br/><br/>
　　**声明：禁止将本软件用于任何非法或犯罪活动，后果自负！**

#### 运行环境

　　要想运行TableGo必须要安装JDK8及以上版本的Java环境，不再支持JDK7，并且要配置好JAVA_HOME或者JRE_HOME，如果是运行Jar包版本的还要把 %JAVA_HOME%\bin 也配置到path变量中去。<br/>
　　在JDK9及以上版本环境中运行TableGo.jar必须要使用脚本运行，在程序压缩包中已提供了TableGo.bat和TableGo.sh的运行脚本，可根据系统环境自行选择运行的脚本。<br/>
　　如果在Mac OS系统中用TableGo.sh脚本运行TableGo报第三方包的类找不到的话可以尝试运行TableGo-all.sh脚本，会动态加载所有的第三方Jar包，一般就能运行起来了，如果还报错可以尝试更新到最新版本的JDK8或JDK9及以上的版本。<br/>
　　因为从JDK9开始不能再使用URLClassLoader动态加载Jar包了，所以数据库驱动无法远能动态加载，经过长时间研究发现可以使用Instrumentation.appendToSystemClassLoaderSearch方法来动态加载Jar包，并且测试没有问题，所以就写了一个tablego-agent.jar来动态加载数据库驱动包。<br/>
　　tablego-agent.jar需要在TableGo.jar运行前使用Java Agent技术加载，相当于JVM级别的AOP，在TableGo.jar运行前先执行，动态加载完Jar包以后再运行TableGo.jar，所以现在运行TableGo.jar的命令就是这样的：java -jar -javaagent:./lib/tablego-agent.jar TableGo.jar<br/>
　　JDK8的版本运行TableGo.jar无需使用Java Agent，可直接双击运行，在代码中做了处理，如果是JDK8的版本还是会使用URLClassLoader动态加载一次数据库驱动包。<br/>
　　EXE版本的TableGo在进行EXE打包的时候就已经配置好了Java Agent，可直接运行。

#### MySQL关键字表名问题

MySQL关键字做表名导致生成代码或文档报错的解决方法，以order表名为例：
1.  先在公共参数中配置精确匹配(包含)参数，把表名`order`填入进去，记得一定要加键盘左上角的“`”引号。
2.  切换到生成工具中生成代码或文档，先把所有关键字表名的表单独生成完。
3.  生成完成以后再到公共参数中把精确匹配(包含)参数中的内容清空。
4.  在公共参数中配置精确匹配(排除)参数，把表名order填入进去，记得一定不能加“`”引号。
5.  切换到生成工具中生成代码或文档，生成所有非关键字命名的表，到这里数据库中所有的表就都生成完了。

#### 自定义模板的写法提示

　　写自定义最简单的方法就是在你的项目代码里找出一套前后台增删查改的标准流程代码出来，把这套代码拷到IDE另一个专门用来写模板的项目中去，直接把文件的后缀都改成ftl，然后在这套标准流程代码上把动态的内容都改成变量，改完之后一套完全适配你项目的模板就做完了。<br/>
　　我已经把SpringMVC、SpringBoot和一些页面的模板示例都写好了，你们可以参考我的模板示例再根据自己的项目框架编写完全适配你们项目的自定义模板就可以了。<br/>
　　在贡献者群会提供我在一些真实项目中写的全套自定义模板代码，如果某个项目的自定义模板与你的项目框架一致，则只需要简单改改就能使用了。<br/>
　　程序中的模板都是用FreeMarker写的，如果不会可以去官网点击下载，进到百度网盘里面有视频教程，很容易学会，学会FreeMarker再参考使用手册和模板示例就能写完全适配自己项目框架的代码模板了。

#### 关于生成的Word和Excel打不开的问题
　　如果生成的Word和Excel文件用MS Office打不开，可以用WPS打开再另存为一次就可以用MS Office打开了(MS Word的容错性不太好)，如果没有装WPS也可以用写字板打开Word，然后另存为docx文件就可以了，推荐用WPS打开或转存，这样文件样式不会受到影响，ER图也会更清楚。Word文档是用docx4j生成的，不知道是基于哪个版本的Word开发出来的，所以多少会有点兼容性问题。

#### 关于升级新版本TableGo的问题
　　一般情况下用新版本直接覆盖老版本是没有问题的，但有时候配置信息改动比较大就会有问题，所以在更新新版本的时候最好先把老版本拷贝到另一个地方临时备份一下，然后再把新版本拷贝进来，dbConfig.xml和paramConfig.xml两个配置文件可以复用，把老的database.ini和paramConfig.ini配置文件删除，再打开新版本的TableGo自动生成database.ini和paramConfig.ini这两个配置文件，因为有的版本配置信息改动比较大，用老版本的配置会有问题。如果老版本有配置如果拷到新版本中来，这时可以同时打开新老版本，在界面上把老版本的配置信息拷贝到新版本的界面上来，完成后再点右上角的关闭按钮正常关闭就会自动保存了界面上的配置信息了。

　　``项目的发展离不开您的支持，希望您能在开源平台给TableGo项目点一个Star，促进项目更好的发展(^_^)∠※``

#### TableGo功能一览

![](http://cdn.tablego.cn/images/function_list.png)

#### 计算机软件著作权

![](http://cdn.tablego.cn/images/copyright.jpg)

**TableGo受国家计算机软件著作权保护（登记号：2020SR0316086），禁止对该软件进行篡改、盗版及非法倒卖等，违者将自行承担相应的法律责任。并且对因用户使用该软件而产生的任何直接或间接损失不承担责任。**
