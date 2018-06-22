import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.greenAccent,
      alignment: Alignment.center,

      // Stacks everything on top of each other
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          const Text(
            "Hello there",
            style: const TextStyle(color: Colors.red),
          ),
          const Text("Hey again",
              style: const TextStyle(color: Colors.green),),
          const Text("Goodbye!",
          style: const TextStyle(color: Colors.blue),),
        ],
      ),

//      child: new Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Text(
//            "Item 1",
//            textDirection: TextDirection.ltr,
//            style: new TextStyle(fontSize: 12.3),
//          ),
//          new Text(
//            "Item 2",
//            textDirection: TextDirection.ltr,
//            style: new TextStyle(fontSize: 12.3),
//          ),
//          const Expanded(
//            child: const Text(
//              "Item 3",
//              textDirection: TextDirection.ltr,
//            ),
//          )
//        ],
//      ),

//      child: new Column(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Text(
//            "First item",
//            textDirection: TextDirection.ltr,
//            style: new TextStyle(
//              color: Colors.white,
//              fontWeight: FontWeight.w900,
//              fontSize: 18.3,
//            ),
//          ),
//          new Text(
//            "Second item",
//            textDirection: TextDirection.ltr,
//            style: new TextStyle(
//              color: Colors.blue,
//              fontWeight: FontWeight.w900,
//              fontSize: 18.3,
//            ),
//          ),
//          new Container(
//            color: Colors.black87,
//            alignment: Alignment.bottomLeft,
//            padding: new EdgeInsets.all(10.0),
//            child: new Text(
//              "Third item",
//              textDirection: TextDirection.ltr,
//              style: new TextStyle(
//                color: Colors.greenAccent,
//                fontWeight: FontWeight.bold,
//                fontStyle: FontStyle.italic,
//                fontSize: 32.6,
//              ),
//            ),
//          )
//        ],
//      ),
    );
  }
}
