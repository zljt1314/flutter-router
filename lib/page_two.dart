import 'package:flutter/material.dart';
import 'package:flutter_router_demo/model/page_info.dart';
import 'package:flutter_router_demo/router_manager.dart';

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 取值
    PageInfo pageInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Two'),
      ),
      body: new Center(
        child: Column(
          children: [_BuildBackBtn(pageInfo: pageInfo), _BuildRouterBtn()],
        ),
      ),
    );
  }
}

class _BuildRouterBtn extends StatelessWidget {
  const _BuildRouterBtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => navigator(context),
      child: Text('Navigator To Page3'),
    );
  }
}

class _BuildBackBtn extends StatelessWidget {
  const _BuildBackBtn({
    Key key,
    @required this.pageInfo,
  }) : super(key: key);

  final PageInfo pageInfo;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: () => Navigator.pop(context, 'back data'),
      child: Text('接收到的信息：'+pageInfo.title +'，点击后返回到上一页'),
    );
  }
}

void navigator(BuildContext context) {
  Navigator.pushNamed(context, RouterManager.ROUTER_PAGE_3);
}
