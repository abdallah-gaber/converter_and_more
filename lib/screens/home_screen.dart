import 'package:converter_and_more/screens/first_point_screen.dart';
import 'package:converter_and_more/screens/second_point_screen.dart';
import 'package:converter_and_more/screens/third_point_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width - 40,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstPointScreen()),
                      );
                    },
                    child: Text("First Point"))),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondPointScreen()),
                      );
                    },
                    child: Text("Second Point"))),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                child:
                    RaisedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdPointScreen()),
                      );
                    }, child: Text("Third Point"))),
            Container(
                width: MediaQuery.of(context).size.width - 40,
                child:
                    RaisedButton(onPressed: () {}, child: Text("Forth Point"))),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
