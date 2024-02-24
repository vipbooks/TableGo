1、不分模块JSON参数配置文件，所有模块的代码都放同一类包目录下
2、分模块JSON参数配置文件，配置默认模块moduleName和moduleList就可以把不同表生成的类放到相应模块包下
3、不分模块增量更新JSON参数配置文件，只生成${tableUpperCamelCase}[java].ftl, ${tableUpperCamelCase}Mapper[xml].ftl两个模板，用于表结构变更的增量更新
4、JSON参数配置文件中的likeFields用于在实体字段上添加SqlCondition.LIKE注解，用于模糊查询；
   searchFields用于在Condition类中添加查询条件；
   noSqlTables用于配置不需要在Mapper类和Mapper.xml中生成查询接口的表，纯单表操作
5、crebas.sql是数据库的DDL，用于初始化生成项目需要的数据库表结构
6、项目工程生成保存的磁盘路径、包路径、Maven坐标、端口、上下文路径、应用名等等参数都可以在JSON参数配置文件中修改
7、生成代码以后可以直接访问Swagger2测试各模块增删查改的接口，Swagger2访问地址在主启动类中，各模块的测试用例生成在test包下
8、如果启动项目打开Swagger看到项目简介那里显示的是“@project.description@API文档”这样的变量参数时，只需要刷新一下项目的Maven再重启项目即可，“@project.description@”变量是取的pom.xml配置文件中的“project.description”参数。