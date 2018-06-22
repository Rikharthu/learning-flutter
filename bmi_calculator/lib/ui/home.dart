import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  num _bmi;

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.pinkAccent,
          title: new Text("BMI"),
        ),
        body: new ListView(
          children: <Widget>[
            new Image.asset(
              "images/bmilogo.png",
              height: 100.0,
            ),
            new Container(
              padding: new EdgeInsets.all(16.0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(
                  new Radius.circular(16.0),
                ),
                color: Colors.grey.shade300,
              ),
              child: new Column(
                children: <Widget>[
                  // Age
                  new TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Age",
                      hintText: "In years",
                      icon: new Icon(Icons.person_outline),
                    ),
                  ),
                  // Height
                  new TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Height",
                      hintText: "In centimeters",
                      icon: new Icon(Icons.insert_chart),
                    ),
                  ),
                  // Weight
                  new TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Weight",
                      hintText: "In kilograms",
                      icon: new Icon(Icons.line_weight),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(top: 32.0),
                    child: new RaisedButton(
                      onPressed: _calculateBmi,
                      color: Colors.pinkAccent,
                      child: new Text(
                        "Calculate",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  new Text("Your BMI is ${_bmi == null ? "Unknown" : _bmi
                      .toStringAsFixed(2)}"),
                  new Text(_bmi == null ? "" : _getBmiCategory(_bmi))
                ],
              ),
            ),
          ],
        ),
      );

  void _calculateBmi() {
    var height = double.tryParse(_heightController.text);
    if (height == null) {
      _bmi = null;
      return;
    }
    var weight = double.tryParse(_weightController.text);
    if (weight == null) {
      setState(() {
        _bmi = null;
      });
      return;
    }

    var bmi = weight / (height * height) * 10000;
    setState(() {
      _bmi = bmi;
    });
  }

  String _getBmiCategory(num bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi <= 24.9) {
      return "Normal weight";
    } else if (bmi <= 29.9) {
      return "Overweight";
    } else {
      return "Obesity";
    }
  }
}
