import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/weather_api.dart' as api;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  num _temperature;

  Future<Map> _getWeather(String city, String code) {
    return api
        .getCurrentWeather(city, code)
        .then((response) => json.decode(response.body));
  }

  @override
  void initState() {
    _getWeather("Riga", "lv").then((weather) {
      setState(() {
        _temperature = weather["main"]["temp"];
      });
    }).catchError((err) => debugPrint(err.toString()));
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            "Klimatic",
            style: new TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: null,
            ),
          ],
        ),
        body: new Stack(
          children: <Widget>[
            new Image.asset(
              "images/umbrella.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            new Container(
              margin: new EdgeInsets.only(
                right: 20.9,
                top: 10.9,
              ),
              alignment: Alignment.topRight,
              child: new Text(
                "Riga",
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            new Container(
              alignment: Alignment.center,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    child: new Image.asset("images/light_rain.png"),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(right: 60.0),
                      alignment: Alignment.center,
                      child: updateTempWidget("Riga", "lv")),
                ],
              ),
            )
          ],
        ),
      );

  Widget updateTempWidget(String city, String countryCode) {
    return new FutureBuilder(
        future: _getWeather(city, countryCode),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          debugPrint("Building temperature widget");
          // where we get all of the json data, we setup widgets etc.
          if (snapshot.hasData) {
            Map content = snapshot.data;
            final String temperature = content["main"]["temp"].toString();
            return new Text(
              "$temperature°C",
              style: new TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
                fontSize: 49.9,
              ),
            );
          }
        });
  }
}
