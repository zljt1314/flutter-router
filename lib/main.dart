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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // routes: RouterManager.routes,
      onGenerateRoute: RouterManager.generateRoute,
      // initialRoute: RouterManager.ROUTER_PAGE_MAIN,
      home: PageOne(),
    );
  }
}

