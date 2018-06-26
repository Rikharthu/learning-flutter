import 'package:flutter/material.dart';

var _cityFieldController = new TextEditingController();

class ChangeCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text('Change City'),
          centerTitle: true,
        ),
        body: new Stack(
          children: <Widget>[
            new Image.asset(
              "images/white_snow.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            new ListView(
              children: <Widget>[
                new ListTile(
                  title: new TextField(
                    decoration: new InputDecoration(
                      hintText: "Enter City",
                    ),
                    controller: _cityFieldController,
                    keyboardType: TextInputType.text,
                  ),
                ),
                new ListTile(
                  title: new FlatButton(
                    onPressed: () {
                      _onGetWeather(context);
                    },
                    textColor: Colors.white70,
                    color: Colors.redAccent,
                    child: new Text("Get Weather"),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  ChangeCity();

  void _onGetWeather(BuildContext context) {
    Navigator.pop(context, {'city': _cityFieldController.text});
  }
}
