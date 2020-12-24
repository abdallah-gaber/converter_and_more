import 'dart:math';

import 'package:flutter/material.dart';

class ThirdPointScreen extends StatefulWidget {
  @override
  _ThirdPointScreenState createState() => _ThirdPointScreenState();
}

enum MethodSelection { firstWay, secondWay }

class _ThirdPointScreenState extends State<ThirdPointScreen> {
  MethodSelection _selectedApproach = MethodSelection.firstWay;
  TextEditingController _nController = TextEditingController();

  int result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Third Point"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text("Getting the Nth Fibonacci number:"),
              SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Text('First Approach'),
                onTap: () {
                  setState(() {
                    _selectedApproach = MethodSelection.firstWay;
                  });
                },
                leading: Radio(
                  value: MethodSelection.firstWay,
                  groupValue: _selectedApproach,
                  onChanged: (MethodSelection value) {
                    setState(() {
                      _selectedApproach = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Second Approach'),
                onTap: () {
                  setState(() {
                    _selectedApproach = MethodSelection.secondWay;
                  });
                },
                leading: Radio(
                  value: MethodSelection.secondWay,
                  groupValue: _selectedApproach,
                  onChanged: (MethodSelection value) {
                    setState(() {
                      _selectedApproach = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                  controller: _nController,
                  onChanged: (value) {
                    if (result != null)
                      setState(() {
                        result = null;
                      });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter N",
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          result = _nController.text.isEmpty
                              ? -1
                              : (_selectedApproach == MethodSelection.firstWay
                                  ? firstApproach(int.parse(_nController.text))
                                  : secondApproach(
                                      int.parse(_nController.text)));
                        });
                      },
                      child: Text(
                        "Get",
                        style: TextStyle(color: Colors.white),
                      ))),
              SizedBox(
                height: 30,
              ),
              if (result != null)
                Center(
                  child: Text(result == -1
                      ? "Enter N to calculate"
                      : "The result: $result"),
                )
            ],
          ),
        )));
  }

  // Reference: http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/fibFormula.html
  int firstApproach(int n) {
    // if (n <= 1) {
    //   return n;
    // }
    // return firstApproach(n-1) + firstApproach(n-2);
    double phi = (1 + sqrt(5)) / 2;
    return (pow(phi, n) / sqrt(5)).round();
  }

  int secondApproach(int n) {
    List<int> fibNumbers = [0, 1];
    for (int i = 2; i <= n; i++) {
      fibNumbers.add(fibNumbers[i - 1] + fibNumbers[i - 2]);
    }

    return fibNumbers[n];
  }
}
