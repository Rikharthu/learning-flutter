import 'dart:async';

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
//                openNextScreen(context);
                _goToNextScreen(context).then((length) {
                  debugPrint("Input length was $length");
                });
              },
              child: new Text("Send to Next Screen"),
            ),
          )
        ],
      ),
    );
  }

  void openNextScreen(BuildContext context) {
    debugPrint("Sending \"${_nameFieldController.text}\"");

    // Create a page route
    // MaterialPageRoute is a Route that handles transitions to the new screen
    // using platform-specific animations
    var router = new MaterialPageRoute(
      builder: (BuildContext context) {
        // Create route content widget
        // Pass necessary data with constructor
        return new NextScreen(name: _nameFieldController.text);
      },
    );

    Navigator.of(context).push(router);
    // Navigator.push will add a Route to the stack of routes managed by the Navigator
  }

  Future _goToNextScreen(BuildContext context) async {
    // We expect Map of results from the next screen
    // This will return data from the next screen, passed in Navigator.pop(context,<data map>)
    Map results = await Navigator.of(context).push(new MaterialPageRoute<Map>(
      builder: (BuildContext context) {
        return new NextScreen(name: _nameFieldController.text);
      },
    ));
    return new Future<int>(() {
      if (results == null) {
        return null;
      } else {
        return results["info"];
      }
    });
  }
}
