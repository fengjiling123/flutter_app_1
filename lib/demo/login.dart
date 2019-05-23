import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'dart:async';

/// 墨水瓶（`InkWell`）可用时使用的样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 16.0,
  color: const Color(0xFF00CACE),
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 16.0,
  color: const Color(0xFFCCCCCC),
);

class LoginPage extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  /// 用户点击时的回调函数。
  final Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  final bool available;

  LoginPage({this.countdown: 60, this.onTapCallback, this.available: false});

  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  //TextEditingController一定要设置在build方法之外  不然build方法每次调用的时候就会重新初始化，使输入的值被清除
  final TextEditingController _usernameControllor = new TextEditingController();
  final TextEditingController _passwordControllor = new TextEditingController();
  //倒计时的计时器
  Timer _timer;

  //倒计时的秒数
  int _seconds;

  bool _available = false;

  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
    _available = widget.available;
  }

  Function _onTapCallback() {
    print('获取验证码');
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds' + 's';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color.fromARGB(
          100, 255, 255, 255), //or set color with: Color(0xFF0000FF)  设置状态栏颜色
    ));
    final double statusBarHeight =
        MediaQuery.of(context).padding.top; //获取状态栏的高度
    // print(statusBarHeight);
    // SystemChrome.setEnabledSystemUIOverlays([]); //影藏状态栏
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);  //恢复状态栏

    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text(
        //     '登陆',
        //     style: new TextStyle(
        //       color: Colors.white,
        //     ),
        //   ),
        //   iconTheme: new IconThemeData(color: Colors.white),
        // ),
        body: new SingleChildScrollView(
            child: SafeArea(
      //SaveArea包裹组件 给页面添加一个状态栏高度的padding 避免状态栏遮挡页面布局
      bottom: false, //不设置某一个方向的安全区域
      child: new ConstrainedBox(
        constraints: new BoxConstraints(minHeight: 120.0),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, //在副轴上的对齐方式 默认是居中对齐
          children: <Widget>[
            // new Padding(
            //   padding: new EdgeInsets.all(0),
            //   child: new Image.asset("images/bg.png"),
            // ),
            new Container(
              height: 150.0,
              child: Center(
                  child: Text(
                '医鹿康',
                style: TextStyle(fontSize: 40.0),
              )),
            ),
            new Padding(
                padding: new EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                child: new Container(
                  padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  decoration: new BoxDecoration(
                      // border: new Border.all(
                      //     color: Color.fromRGBO(215, 222, 243, 0.41),
                      //     width: 0.5), //边色与宽度
                      color: Colors.white, //底色
                      borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(215, 222, 243, 0.41),
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0)
                      ]),
                  child: new TextField(
                      style:
                          new TextStyle(fontSize: 15.0, color: Colors.black54),
                      controller: _usernameControllor, //控制器，控制文本的内容，
                      //在build方法之前初始化控制器 final TextEditingController _usernameControllor = new TextEditingController();
                      // autofocus: true, //自动获得焦点
                      keyboardType: TextInputType.number, //设置输入框文本类型 ？？？貌似不起效果
                      // textAlign: TextAlign.right,  设置textAlign就会报错
                      decoration: new InputDecoration(
                          hintText: '请输入您的手机号',

                          // icon: new Container(
                          //   padding: EdgeInsets.all(0.0),
                          //   child: new Icon(Icons.person),
                          // ),
                          // suffixIcon: _usernameControllor.text!=''
                          //     ? new Icon(Icons.clear)
                          //     : null,
                          // errorText: '输入错误' ？？？如何控制显示
                          border: InputBorder.none //取消默认的下划线边框

                          ),
                      obscureText: false, //输入是否不可见

                      onChanged: (String str) {
                        print('你输入的用户名是$str');
                        if (str != '') {
                          _available = true;
                        } else {
                          _available = false;
                        }
                        setState(() {});
                      },
                      onSubmitted: (String str) {
                        //失去焦点的时候调用
                        print('你提交的用户名是$str');
                      }),
                )),
            new Padding(
                padding: new EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 10.0),
                child: new Container(
                    padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                    decoration: new BoxDecoration(
                        // border: new Border.all(
                        //     color: Color.fromRGBO(215, 222, 243, 0.41),
                        //     width: 0.5), //边色与宽度
                        color: Colors.white, //底色
                        borderRadius:
                            new BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(215, 222, 243, 0.41),
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0,
                              spreadRadius: 2.0)
                        ]),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: new TextField(
                            style: new TextStyle(
                                fontSize: 15.0, color: Colors.black54),
                            controller: _passwordControllor,
                            decoration: new InputDecoration(
                              hintText: '请输入短信验证码',
                              border: InputBorder.none,
                            ),

                            obscureText: true, //输入是否不可见
                          ),
                        ),
                        _available
                            ? InkWell(
                                child: Text(
                                  '  $_verifyStr  ',
                                  style: inkWellStyle,
                                ),
                                onTap: (_seconds == widget.countdown)
                                    ? () {
                                        _startTimer();
                                        inkWellStyle = _unavailableStyle;
                                        _verifyStr = '已发送$_seconds' + 's';
                                        setState(() {});
                                        // widget.onTapCallback();  //  ？？？此处报错
                                        _onTapCallback();
                                      }
                                    : null,
                              )
                            : InkWell(
                                child: Text('获取验证码', style: _unavailableStyle),
                              )
                      ],
                    ))),
            new Padding(
              padding: EdgeInsets.fromLTRB(45.0, 43.0, 30.0, 11.0),
              child: new Text(
                '登陆后代表您同意《819用户协议》',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1), fontSize: 13.0),
              ),
            ),
            new Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 26.0),
              child: Container(
                width: double.infinity,
                height: 46.0,
                child: Center(
                  child: Text(
                    '登陆',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                  color: Color.fromRGBO(26, 156, 247, 1),
                ),
              ),
            )
            // new Padding(
            //   padding: new EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 10.0),
            //   child: new TextField(
            //     style: new TextStyle(fontSize: 15.0, color: Colors.black54),
            //     controller: _passwordControllor,
            //     decoration: new InputDecoration(
            //       labelText: '密码',
            //       hintText: '请输入密码',
            //       icon: new Container(
            //         padding: EdgeInsets.all(0.0),
            //         child: new Icon(Icons.party_mode),
            //       ),
            //     ),
            //     obscureText: true, //输入是否不可见
            //   ),
            // )
          ],
        ),
      ),
    )));
  }
}
