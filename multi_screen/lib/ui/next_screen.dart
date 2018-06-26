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
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text("Hello, ${widget.name}!"),
            ),
            new ListTile(
              title: new RaisedButton(
                onPressed: () {
                  _goToPreviousScreen(context);
                },
                child: new Text("Go Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToPreviousScreen(BuildContext context) {
    // Return to the first screen using Navigator.pop
    // Navigator.pop removes the current Route from the stack of routes managed by the navigator
    // Navigator.pop(context);
    // or:
    // Navigator.of(context).pop();

    // Also pass some data when popping back
    Navigator.pop(context, {'info': widget.name.length});
  }
}
