/*
kulina - Routes
created by: stefensuhat at 10 Apr 2020 22.24
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kulinaapp/global/constant.dart';
import 'package:kulinaapp/modules/cart/cart.dart';
import 'package:kulinaapp/modules/product/product.dart';

class Routes {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => Product());
        break;
      case cartPage:
        return MaterialPageRoute(builder: (_) => Cart());
        break;
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('404 | Not Found'),
            ),
          ),
        );
    }
  }
}
