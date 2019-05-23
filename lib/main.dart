import 'package:flutter/material.dart'; //谷歌推出的视觉设计语言，包括按钮、标题、选择框、布局、图片、装饰器等组件库

import 'package:flutter_app_1/demo/login.dart';

import 'package:flutter_app_1/demo/myApp.dart';

void main() {
  //runApp是flutter框架的入口
  //初始化Material风格App
  // runApp(new MaterialApp(
  //   title: 'My app', // used by the OS task switcher
  //   theme: new ThemeData(primaryColor: Colors.green),
  //   home: new LoginPage(),
  // ));
  runApp(new MyApp());
}
