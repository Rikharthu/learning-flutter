import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klimatic/ui/change_city.dart';

import '../api/weather_api.dart' as api;

class Klimatic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  String _city = "Riga";

  Future _goToSelectCityScreen(BuildContext context) async {
    Map results = await Navigator
        .of(context)
        .push(new MaterialPageRoute<Map>(builder: (context) {
      return new ChangeCity();
    }));

    if (results != null && results.containsKey('city')) {
      var city = results['city'];
      debugPrint(city);
      return city;
    } else {
      return new Future.error("City is null");
    }
  }

  Future<Map> _getWeather(String city) {
    return api
        .getCurrentWeather(city)
        .then((response) => json.decode(response.body));
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
              onPressed: () {
                _goToSelectCityScreen(context)
                    .then((city) => setState(() {
                          this._city = city;
                        }))
                    .catchError((err) => debugPrint(err.toString()));
              },
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
                _city,
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
                      child: updateTempWidget(_city)),
                ],
              ),
            )
          ],
        ),
      );

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: _getWeather(city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          debugPrint("Building temperature widget");
          // where we get all of the json data, we setup widgets etc.
          if (snapshot.hasData) {
            Map content = snapshot.data;
            var code = content['cod'];
            if (code != 200) {
              debugPrint("code is not 200: $code");
              return new Text(
                "Unknown city: \"$city\"",
                style: new TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 36.9,
                ),
              );
            } else {
              debugPrint(content.toString());
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
          }
        });
  }
}
