import 'dart:math';

import 'package:flutter/material.dart';

class MakeItRain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MakeItRainState();
}

class _MakeItRainState extends State<MakeItRain> {
  int _moneyCounter = 0;
  var _random = new Random(new DateTime.now().millisecond);

  void _rainMoney() {
    // Update state
    setState(() {
      _moneyCounter += _random.nextInt(500);
    });
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text("Make it Rain!"),
          backgroundColor: Colors.lightGreen,
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              // Title
              new Center(
                child: new Text(
                  "Get Rich",
                  style: new TextStyle(
                      fontSize: 29.9,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400),
                ),
              ),
              // Balance
              new Expanded(
                child: new Center(
                  child: new Text(
                    "\$$_moneyCounter",
                    style: new TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 46.9,
                      fontWeight: _moneyCounter >= 10000
                          ? FontWeight.bold
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
              new Expanded(
                  child: new Center(
                child: new FlatButton(
                    color: Colors.lightGreen,
                    textColor: Colors.white70,
                    onPressed: _rainMoney,
                    child: new Text(
                      "Let It Rain!",
                      style: new TextStyle(
                        fontSize: 19.9,
                      ),
                    )),
              ))
            ],
          ),
        ),
      );
}
