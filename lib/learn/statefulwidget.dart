import 'package:flutter/material.dart';

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return new Text('count$count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('点击减少'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CounterState();
  }
}

class CounterState extends State<Counter> {
  int _count = 0;
  void increment() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('可变组件'),
      ),
      body: new Row(
        children: <Widget>[
          new CounterDisplay(count: _count),
          new CounterIncrementor(onPressed: increment)
        ],
      ),
    );
  }
}
