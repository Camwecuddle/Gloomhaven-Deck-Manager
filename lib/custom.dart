import 'package:flutter/material.dart';
import 'package:GHDeckCalculator/customdeck.dart';
import 'package:flutter/services.dart';
// import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';

class Custom extends StatefulWidget {
  @override
  _CustomState createState() => _CustomState();
}

class _CustomState extends State<Custom> {
  int _deckSize = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Deck Size"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      if (_deckSize > 0) _deckSize -= 1;
                    });
                  },
                ),
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  child: Text(
                    '$_deckSize',
                    style: TextStyle(color: Colors.black, fontSize: 100),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _deckSize += 1;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CustomDeck(_deckSize)),
          );
        },
        tooltip: 'Done',
        child: Text("Done"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
