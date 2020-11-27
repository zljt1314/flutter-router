import 'package:flutter/material.dart';
import 'package:flutter_router_demo/router_manager.dart';

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Three'),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () => navigatorBackPage1(context),
              child: Text('Back To Page1'),
            ),
            RaisedButton(
              onPressed: () => navigatorReplacePage4(context),
              child: Text('Navigator Replace Page4'),
            ),
            RaisedButton(
              onPressed: () => navigatorRemoveAllPage(context),
              child: Text('Navigator Remove All Page'),
            ),
            RaisedButton(
              onPressed: () => navigatorToPage4AndRemoveAllPage(context),
              child: Text('Navigator To Page4 And Remove All Page'),
            ),
          ],
        ),
      ),
    );
  }
}

// 场景1：已有page1>page2>page3，从page3返回到page1。
void navigatorBackPage1(BuildContext context) {
  Navigator.popUntil(
      context, ModalRoute.withName(RouterManager.ROUTER_PAGE_MAIN));
}

// 场景2：已有page1>page2>page3，替换page3为page4。
void navigatorReplacePage4(BuildContext context) {
  Navigator.popAndPushNamed(context, RouterManager.ROUTER_PAGE_4);
  // Navigator.pushReplacementNamed(context, RouterManager.ROUTER_PAGE_4);
}

// 场景3：已有page1>page2>page3，删除所有记录，只显示page1或page2，一般page1为首页。
void navigatorRemoveAllPage(BuildContext context) {
  // 这种方式是删除所有的路由，/page1页变成最底层的页面，这种方式可以用作返回首页
  Navigator.pushNamedAndRemoveUntil(context, RouterManager.ROUTER_PAGE_MAIN, (route) => false);
}

// 场景4：已有page1>page2>page3，显现page4页面，删除所有记录只保留page1。
void navigatorToPage4AndRemoveAllPage(BuildContext context) {
  // 跳转到page4后返回会回到page1
  Navigator.pushNamedAndRemoveUntil(context, RouterManager.ROUTER_PAGE_4,ModalRoute.withName(RouterManager.ROUTER_PAGE_MAIN));
}
