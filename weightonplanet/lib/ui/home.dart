import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Planet _selectedPlanet = Planet.pluto;
  num _weight;

  TextEditingController _weightController = new TextEditingController();

  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
            title: new Text(
              "Weight On Planet X",
            ),
            centerTitle: true,
            backgroundColor: Colors.black38),
        backgroundColor: Colors.blueGrey,
        body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView(
            padding: const EdgeInsets.all(2.5),
            children: <Widget>[
              new Image.asset(
                "images/planet.png",
                width: 133.0,
                height: 133.0,
              ),
              new Container(
                margin: const EdgeInsets.all(3.0),
                alignment: Alignment.center,
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) {
                        _onPlanetSelected(_selectedPlanet);
                      },
                      decoration: new InputDecoration(
                        labelText: "Your Weight on Earth",
                        hintText: "In Pounds",
                        icon: new Icon(Icons.person_outline),
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Radio<Planet>(
                            value: Planet.pluto,
                            groupValue: _selectedPlanet,
                            onChanged: _onPlanetSelected,
                            activeColor: Colors.brown,
                          ),
                          new Text(
                            "Pluto",
                            style: new TextStyle(
                              color: Colors.white30,
                            ),
                          ),
                          new Radio<Planet>(
                            value: Planet.mars,
                            groupValue: _selectedPlanet,
                            onChanged: _onPlanetSelected,
                            activeColor: Colors.red,
                          ),
                          new Text(
                            "Mars",
                            style: new TextStyle(
                              color: Colors.white30,
                            ),
                          ),
                          new Radio<Planet>(
                            value: Planet.venus,
                            groupValue: _selectedPlanet,
                            onChanged: _onPlanetSelected,
                            activeColor: Colors.orangeAccent,
                          ),
                          new Text(
                            "Venus",
                            style: new TextStyle(
                              color: Colors.white30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(top: 31.2),
                      child: new Text(
                        _weight != null
                            ? "Your weight on ${_getPlanetLabel(
                            _selectedPlanet)} is ${_weight.toStringAsFixed(2)}"
                            : "",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 19.4,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void _onPlanetSelected(Planet newPlanet) {
    debugPrint("Selected $newPlanet");
    var weightInput = _weightController.text;
    num tmpWeight;
    try {
      tmpWeight = _getWeightOnPlanet(double.parse(weightInput), newPlanet);
    } on FormatException catch (e) {
      tmpWeight = null;
    }
//    var tmpWeight=getWeightOnPlanet(_weightController., planet)
    setState(() {
      _selectedPlanet = newPlanet;
      _weight = tmpWeight;
    });
  }

  num _getWeightOnPlanet(num pounds, Planet planet) {
    switch (planet) {
      case Planet.pluto:
        return pounds * 0.06;
      case Planet.mars:
        return pounds * 0.38;
      case Planet.venus:
        return pounds * 0.91;
    }
  }

  String _getPlanetLabel(Planet planet) {
    switch (planet) {
      case Planet.pluto:
        return "pluto";
      case Planet.mars:
        return "mars";
      case Planet.venus:
        return "venus";
    }
  }
}

enum Planet { pluto, mars, venus }
