import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.greenAccent.shade700,
          title: new Text("Fancy day"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () {
                debugPrint("Icon tapped");
              },
            ),
            new IconButton(
              icon: new Icon(Icons.search),
              onPressed: _onPressed,
            ),
          ],
        ),
        backgroundColor: Colors.lightGreen.shade50,
        body: new Container(
          alignment: Alignment.center,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Bonni",
                style: new TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepOrange,
                ),
              ),
              new InkWell(
                child: new Container(
                  padding: new EdgeInsets.all(12.0),
                  child: new Text("Button"),
                ),
                onTap: () {
                  print("Button tapped");
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
          currentIndex: 1,
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text("Add"),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.remove),
              title: new Text("Remove"),
            )
          ],
          onTap: (int i) {
            debugPrint("You touched $i");
          },
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          tooltip: "Going Up!",
          child: new Icon(Icons.call_missed),
          onPressed: () {
            debugPrint("Tapped on FAB");
          },
        ),
      );
}

void _onPressed() {
  print("Search tapped!");
}
