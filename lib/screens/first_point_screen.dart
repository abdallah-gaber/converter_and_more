import 'package:flutter/material.dart';

class FirstPointScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Point"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text("Q:"),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.grey.shade400,
                child: Text(
                    """• Add arithmetic operators (add, subtract, multiply, divide) to make the following
    expressions true. You can use any parentheses you’d like.
    2.25 4.50 1.25 5 = 27"""),
              ),
              SizedBox(height: 50,),
              Text("A:"),
              SizedBox(height: 10,),
              Container(padding: EdgeInsets.all(20),
                color: Colors.grey.shade400,
              child: Text("((2.25 + 4.5) / 1.25) * 5 = 27"),)
            ],
          ),
        ),
      ),
    );
  }
}
