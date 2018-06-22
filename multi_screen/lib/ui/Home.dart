import 'package:flutter/material.dart';
import 'package:multi_screen/ui/next_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _nameFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _nameFieldController,
              decoration: new InputDecoration(
                labelText: "Enter Your Name",
                hintText: "Your Name",
              ),
            ),
          ),
          new ListTile(
            title: new RaisedButton(
              onPressed: () {
                debugPrint("Sending \"${_nameFieldController.text}\"");
                var router =
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new NextScreen(name: _nameFieldController.text);
                });
                Navigator.of(context).push(router);
              },
              child: new Text("Send to Next Screen"),
            ),
          )
        ],
      ),
    );
  }
}
