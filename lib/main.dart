import 'package:flutter/material.dart';
// import 'package:flutter_app_1/learn/gestureDetector.dart';
// import 'package:flutter_app_1/learn/statefulwidget.dart';
// import 'package:flutter_app_1/learn/shoping.dart';

import 'package:flutter_app_1/demo/login.dart';

void main() {
  runApp(new MaterialApp(
    title: 'My app', // used by the OS task switcher
    // home: new ShoppingList(
    //   products: <Product>[
    //     new Product(name: 'aa'),
    //     new Product(name: 'ss'),
    //     new Product(name: 'ss'),
    //     new Product(name: 'saa')
    //   ],
    // ),
    theme: new ThemeData(
      primaryColor: Colors.green
    ),
    home: new LoginPage(),
  ));
}
