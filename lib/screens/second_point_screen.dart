import 'package:flutter/material.dart';

class SecondPointScreen extends StatefulWidget {
  @override
  _SecondPointScreenState createState() => _SecondPointScreenState();
}

class _SecondPointScreenState extends State<SecondPointScreen> {
  TextEditingController _firstSentenceController = TextEditingController(),
      _secondSentenceController = TextEditingController();

  String anagramStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Point"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Expanded(
                child: Text(
                    "Enter 2 sentences and tap Check to see if they are anagrams or not.")),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: _firstSentenceController,
              onChanged: (txt) {
                if (anagramStatus != null) {
                  setState(() {
                    anagramStatus = null;
                  });
                }
              },
              decoration: InputDecoration(hintText: "First Sentence"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _secondSentenceController,
              onChanged: (txt) {
                if (anagramStatus != null) {
                  setState(() {
                    anagramStatus = null;
                  });
                }
              },
              decoration: InputDecoration(hintText: "Second Sentence"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        anagramStatus = checkAnagram(
                            _firstSentenceController.text,
                            _secondSentenceController.text,
                            sortedCharactersList);
                      });
                    },
                    child: Text(
                      "Check",
                      style: TextStyle(color: Colors.white),
                    ))),
            SizedBox(
              height: 30,
            ),
            if (anagramStatus != null) Center(child: Text(anagramStatus))
          ],
        ),
      )),
    );
  }

  String checkAnagram(
      String firstSentence, String secondSentence, Function sortFunction) {
    if (firstSentence.isEmpty || secondSentence.isEmpty) {
      return "Enter sentences first!";
    }

    if (firstSentence.length != secondSentence.length) {
      return "Not Anagrams!";
    }

    List<String> firstSentenceCharactersSorted =
        sortedCharactersList(firstSentence);
    List<String> secondSentenceCharactersSorted =
        sortedCharactersList(secondSentence);

    for (int i = 0; i < firstSentenceCharactersSorted.length; i++) {
      if (firstSentenceCharactersSorted[i] !=
          secondSentenceCharactersSorted[i]) {
        return "Not Anagrams!";
      }
    }
    return "Anagrams!";
  }

  List<String> sortedCharactersList(String sentence) {
    List<String> sentenceCharacters = sentence.split('');
    sentenceCharacters.sort();
    return sentenceCharacters;
  }
}
