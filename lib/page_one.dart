import 'package:flutter/material.dart';
import 'package:flutter_router_demo/model/page_info.dart';
import 'package:flutter_router_demo/page_two.dart';
import 'package:flutter_router_demo/router_manager.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page One'),
      ),
      body: Center(
        child: new RaisedButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>new PageTwo()));
            // navigator1(context);
            // navigator2(context);
            navigator3(context);
          },
          child: Text('Navigator To Page2'),
        ),
      ),
    );
  }

  // 通用路由
  void navigator1(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PageTwo(); // 跳转到的新页面
    }));
  }

  // 定制路由
  void navigator2(BuildContext context) {
    Navigator.push(
        context,
        new PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (BuildContext context, _, __) {
              return new PageTwo();
            },
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(
                opacity: animation,
                child: new RotationTransition(
                  turns: new Tween<double>(begin: 0.0, end: 1.0)
                      .animate(animation),
                  child: child,
                ),
              );
            }));
  }

  void navigator3(BuildContext context) async {
    PageInfo pageInfo = PageInfo(title: 'title', subTitle: 'subTitle');
    var backData = await Navigator.pushNamed(context, RouterManager.ROUTER_PAGE_2, arguments: pageInfo);
    if(backData != null) {
      print(backData);
    }
  }
}
