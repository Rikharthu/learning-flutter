import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  // All instance variables inside StatelessWidget should be final
  final String title;

  Home({Key key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Center(
          child: new CustomButton(),
        ),
      );
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new GestureDetector(
        onDoubleTap: () {
          final snackBar = new SnackBar(
            content: new Text("Double Tap!"),
            backgroundColor: Colors.red,
            duration: new Duration(milliseconds: 200),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        onTap: () {
          final snackBar = new SnackBar(
            content: new Text("Single Tap!"),
            backgroundColor: Theme.of(context).backgroundColor,
            duration: new Duration(milliseconds: 200),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: new Container(
          padding: new EdgeInsets.all(18.0),
          decoration: new BoxDecoration(
              color: Theme.of(context).buttonColor,
              borderRadius: new BorderRadius.circular(5.5)),
          child: new Text("First Button"),
        ),
      );
}
