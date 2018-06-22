import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

// http://jsonplaceholder.typicode.com/posts

class _HomeState extends State<Home> {
  List<dynamic> _posts = new List(0);

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.purpleAccent,
          title: new Text("Networking Sandbox"),
        ),
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              alignment: Alignment.center,
              child: new RaisedButton(
                color: Colors.purpleAccent,
                onPressed: _downloadData,
                child: new Text(
                  "Download",
                  style: new TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Container(
                child: new ListView.builder(
                  padding: const EdgeInsets.all(14.5),
                  itemBuilder: _buildListItem,
                  itemCount: _posts.length,
                ),
              ),
            ),
          ],
        ),
      );

  void _downloadData() {
    _getJson().then((posts) {
      for (var post in posts) {
        debugPrint(post["title"]);
      }
      setState(() {
        _posts = posts;
      });
    }).catchError((err) {
      setState(() {
        _posts = new List(0);
      });
    });
  }

  Future<List<dynamic>> _getJson() async {
//    http.get("http://jsonplaceholder.typicode.com/posts").then((data) {
//      debugPrint(data.body);
//    }).catchError((err) => debugPrint(err));

    var response = await http.get("http://jsonplaceholder.typicode.com/posts");

    return json.decode(response.body);
  }

  Widget _buildListItem(BuildContext context, int index) {
    var post = _posts[index];
    debugPrint("Creating post widget for index #$index");
    return new Column(
      children: <Widget>[
        new Divider(
          height: 5.5,
        ),
        new ListTile(
          onTap: () => _onPostSelected(post),
          title: Text(
            post["title"],
            style: new TextStyle(fontSize: 17.9),
          ),
          subtitle: new Text(
            post["body"],
            style: new TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 13.9),
          ),
          leading: new CircleAvatar(
            backgroundColor: Colors.greenAccent,
            child: new Text(
              post["body"][0],
              style: new TextStyle(
                fontSize: 13.5,
                color: Colors.orangeAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onPostSelected(dynamic post) {
    debugPrint("Selected ${post["title"]}");
    var alert = new AlertDialog(
      title: Text(post["title"]),
      content: Text(post["body"]),
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
}
