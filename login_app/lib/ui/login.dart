import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _welcomeString = "";

  void _onLogin() {
    var username = _userController.text;
    var password = _passwordController.text;
    bool hasErrors = false;
    if (username == null && username.isEmpty) {
      debugPrint("Please enter your username");
      hasErrors = true;
    }
    if (password == null && password.isEmpty) {
      debugPrint("Please enter your password");
      hasErrors = true;
    }

    if (!hasErrors) {
      setState(() {
        _welcomeString = "Hello, $username";
      });
    } else {
      setState(() {
        _welcomeString = "";
      });
    }
  }

  void _onClear() {
    _userController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text("Login"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        backgroundColor: Colors.blueGrey,
        body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView( // ListView is scrollable, apart from Column
            children: <Widget>[
              // image
              new Image.asset(
                "images/face.png",
                width: 90.0,
                height: 90.0,
                color: Colors.lightGreen,
              ),
              // form
              new Container(
                height: 180.0,
                width: 380.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _userController,
                      decoration: new InputDecoration(
                        hintText: "Username",
                        icon: new Icon(Icons.person),
                      ),
                    ),
                    new TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: new InputDecoration(
                        hintText: "Password",
                        icon: new Icon(Icons.lock),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 10.5),
                      child: new Center(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // Login button
                            new Container(
                              child: new RaisedButton(
                                color: Colors.redAccent,
                                onPressed: _onLogin,
                                child: new Text(
                                  "Login",
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.9,
                                  ),
                                ),
                              ),
                            ),
                            new Container(
                              child: new RaisedButton(
                                color: Colors.redAccent,
                                onPressed: _onClear,
                                child: new Text(
                                  "Clear",
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.9,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(top: 24.0),
                child: new Text(
                  _welcomeString,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 24.5
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
