import 'package:flutter/material.dart';
import 'package:flutter_router_demo/page_err.dart';
import 'package:flutter_router_demo/page_four.dart';
import 'package:flutter_router_demo/page_one.dart';
import 'package:flutter_router_demo/page_three.dart';
import 'package:flutter_router_demo/page_two.dart';

class RouterManager {
  static const ROUTER_PAGE_MAIN = '/';
  static const ROUTER_PAGE_2 = '/page2';
  static const ROUTER_PAGE_3 = '/page3';
  static const ROUTER_PAGE_4 = '/page4';
  static const ROUTER_PAGE_5 = '/page5';

  static final routes = {
    ROUTER_PAGE_MAIN: (context) => PageOne(),
    ROUTER_PAGE_2: (context) => PageTwo(),
    ROUTER_PAGE_3: (context) => PageThree(),
    ROUTER_PAGE_4: (context) => PageFour(),
  };

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
  }

  static MaterialPageRoute page(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return page;
      },
    );
  }
}
