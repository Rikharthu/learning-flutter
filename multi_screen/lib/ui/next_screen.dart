import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  final String name;

  @override
  _NextScreenState createState() => _NextScreenState();

  NextScreen({Key key, this.name}) : super(key: key);
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Next Screen"),
      ),
      body: new Container(
        child: new Text("Hello, ${widget.name}!"),
      ),
    );
  }
}
