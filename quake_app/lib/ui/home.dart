import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> _quakes = new List(0);

  @override
  void initState() {
    const url =
        "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

    http.get(url).then((result) => json.decode(result.body)).then((quakesJson) {
      setState(() {
        _quakes = quakesJson["features"];
      });
    }).catchError((err) => debugPrint(err.toString()));
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text("Quakes"),
          backgroundColor: Colors.redAccent,
        ),
        body: new ListView.builder(
          itemBuilder: _createQuakeItem,
          itemCount: _quakes.length,
        ),
      );

  Widget _createQuakeItem(BuildContext context, int index) {
    var quakeProperties = _quakes[index]["properties"];
    var dateFormat = new DateFormat("MMMM M, y h:mm a");
    var dateTime =
        new DateTime.fromMillisecondsSinceEpoch(quakeProperties["time"]);

    return new Column(
      children: <Widget>[
        new Divider(
          height: 5.5,
        ),
        new ListTile(
          onTap: () => _onQuakeSelected(quakeProperties),
          // Title
          title: new Text(
            dateFormat.format(dateTime),
            style: new TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          // Place
          subtitle: new Text(
            quakeProperties["place"],
            style: new TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          // Magnitude
          leading: new CircleAvatar(
            backgroundColor: _getMagnitudeColor(quakeProperties["mag"]),
            child: new Text(
              quakeProperties["mag"].toString(),
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onQuakeSelected(dynamic quake) {
    var alert = new AlertDialog(
      title: Text("Quakes"),
      content: Text(quake["title"]),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text("OK"),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  MaterialColor _getMagnitudeColor(magnitude) {
    if (magnitude <= 2.5) {
      return Colors.green;
    } else if (magnitude <= 5.4) {
      return Colors.lightGreen;
    } else if (magnitude <= 5.4) {
      return Colors.yellow;
    } else if (magnitude <= 6.0) {
      return Colors.orange.shade300;
    } else if (magnitude <= 6.9) {
      return Colors.orange;
    } else if (magnitude <= 7.9) {
      return Colors.deepOrange.shade500;
    } else {
      return Colors.red.shade900;
    }
  }
}
