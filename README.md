# Flutter路由总结

### 什么是路由？
* 路由(Route)在移动开发中通常指页面（Page），这跟web开发中单页应用的Route概念意义是相同的，Route在Android中通常指一个Activity，在iOS中指一个ViewController。

### 什么是路由管理
* 所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter中的路由管理和原生开发类似，无论是Android还是iOS，导航管理都会维护一个路由栈，路由入栈(push)操作对应打开一个新页面，路由出栈(pop)操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。

### Navigator是什么？
* Navigator是一个路由管理的组件，它提供了打开和退出路由页方法。Navigator通过一个栈来管理活动路由集合。通常当前屏幕显示的页面就是栈顶的路由。Navigator提供了一系列方法来管理路由栈，比如push，pop等。

### 路由实战
#### 第一种方式：最简单的页面跳转
```
//导航到新路由   
 Navigator.push( context,
  MaterialPageRoute(builder: (context) {
     return PageOne("参数"); // 跳转到的新页面
  }));
```
#### 第二种方式：定制路由

**通常，我们可能需要定制路由以实现自定义的过渡效果等。定制路由有两种方式：**

* 继承路由子类，如：PopupRoute、ModalRoute 等。
* 使用 PageRouteBuilder 类通过回调函数定义路由。

**下面使用 PageRouteBuilder 实现一个页面旋转淡出的效果。**

```
onTap: () async {
  String result = await Navigator.push(
      context,
      new PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000),
        pageBuilder: (context, _, __) =>
            new ContentScreen(articles[index]),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) =>
                new FadeTransition(
                  opacity: animation,
                  child: new RotationTransition(
                    turns: new Tween<double>(begin: 0.0, end: 1.0)
                        .animate(animation),
                    child: child,
                  ),
                ),
      ));

  if (result != null) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: new Text("$result"),
        duration: const Duration(seconds: 1),
      ),
    );
  }
},
```



#### 第三种方式：命名路由
==在Flutter最初的版本中，命名路由是不能传递参数的，后来才支持了参数.==

==当使用 initialRoute 时，需要确保你没有同时定义 home 属性。==

==通常，移动应用管理着大量的路由，并且最容易的是使用名称来引用它们。路由名称通常使用路径结构：“/a/b/c”，主页默认为 “/”。==
* 所谓“命名路由”（Named Route）即有名字的路由，我们可以先给路由起一个名字，然后就可以通过路由名字直接打开新的路由了，这为路由管理带来了一种直观、简单的方式。

```
MaterialApp(
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  
  // 使用“/”命名路由来启动应用（Start the app with the "/" named route. In our case, the app will start）
  // 在这里，应用将从 FirstScreen Widget 启动（on the FirstScreen Widget）
  
  initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    // 当我们跳转到“/”时，构建 FirstScreen Widget（When we navigate to the "/" route, build the FirstScreen Widget）
    '/': (context) => FirstScreen(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    // 当我们跳转到“/second”时，构建 SecondScreen Widget（When we navigate to the "/second" route, build the SecondScreen Widget）
    '/second': (context) => SecondScreen(),
  },
);
```
 **为了方便管理，咱们可以把所有的路由路径单独提出来，抽成一个单独的routers.dart文件。**

```
final routes = {
  '/': (context) => MyHomePage(),
  '/page1': (context) => PageOne(),
  '/page2': (context) => PageTwo(),
  '/page3': (context) => PageThree(),
};
```
**main.dart如下：**
```
import 'package:flutter/material.dart';
import 'router/routers.dart'; // 引入路由文件的路径

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // 这里控制默认显示的首页，/视为根路径，比如：/login,/home等都可
      routes: routes,
    );
  }
}
```
**调用方式如下：**
```
// 带参数跳转
Navigator.pushNamed(context, '/page2', arguments: 'hello'); // arguments是固定参数，后面跟上要传的内容，比如id，type等
```

```
onPressed: () async {
 // 获取下一页返回过来数据的方法，打开新页面page3后，便会等着返回，返回此页时就能拿到page3返回的数据
  var res = await Navigator.pushNamed(context, '/page3'); 
  print(res);
})
```

**在路由页通过RouteSetting对象获取路由参数**
```
// 获取路由参数，返回字符串
var args=ModalRoute.of(context).settings.arguments;
```
**回退上一页并返回数据**
```
Navigator.pop(context, '返回参数');
```

```
Navigator.of(context).canPop(); // 判断当前页面能否进行pop操作，并返回bool值
```


*** 场景模拟
* **场景1：已有page1>page2>page3，从page3返回到page1。**

```
Navigator.popUntil(context, ModalRoute.withName('/page1'));
```
* **场景2：已有page1>page2>page3，替换page3为page4。**

```
Navigator.popAndPushNamed(context, '/page4');
Navigator.pushReplacementNamed(context, '/page4');
```

* **场景3：已有page1>page2>page3，删除所有记录，只显示page1或page2，一般page1为首页。**


```
Navigator.pushNamedAndRemoveUntil(context, '/page1', (Route<dynamic> route) => false); // 这种方式是删除所有的路由，/page1页变成最底层的页面，这种方式可以用作返回首页
```

* **场景4：已有page1>page2>page3，显现page4页面，删除所有记录只保留page1。**

```
Navigator.pushNamedAndRemoveUntil(context, '/page4', ModalRoute.withName('/page1')); // 从page4返回会回到page1
```

* **场景5：要是访问的这个页面不存在该怎么处理？**

**onGenerateRoute 拦截器：** 

*MaterialApp有一个onGenerateRoute属性，它在打开命名路由时可能会被调用，之所以说可能，是因为当调用Navigator.pushNamed(…)打开命名路由时，如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，才会调用onGenerateRoute来生成路由。*

++假设我们要开发一个电商APP，当用户没有登录时可以看店铺、商品等信息.
但交易记录、购物车、用户个人信息等页面需要登录后才能看。为了实现上述功能，我们需要在打开每一个路由页前判断用户登录状态！如果每次打开路由前我们都需要去判断一下将会非常麻烦，那有什么更好的办法吗？答案是有！ —— onGenerateRoute++

- onGenerateRoute 可以做拦截器
- onGenerateRoute可以变相的接受参数
- 可以在onGenerateRoute（）函数中提取参数并将它们传递给widget，而不是直接在窗口小部件中提取参数。
- ==注意，onGenerateRoute只会对命名路由生效==。

```
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    print(arguments);
    switch (settings.name) {
      case ROUTER_PAGE_MAIN:
        return page(settings, PageOne());
      case ROUTER_PAGE_2:
        return page(settings, PageTwo());
      case ROUTER_PAGE_3:
        return page(settings, PageThree());
      case ROUTER_PAGE_4:
        return page(settings, PageFour());
      default:
        return page(settings, ErrorRoutePage(settings.name));
    }
  
```

```
import 'package:flutter/material.dart';
import 'package:flutter_router_demo/page_one.dart';
import 'package:flutter_router_demo/router_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouterManager.generateRoute,
      home: PageOne(),
    );
  }
}
```

