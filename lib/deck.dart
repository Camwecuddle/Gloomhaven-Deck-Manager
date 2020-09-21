import 'package:flutter/material.dart';

class Deck extends StatefulWidget {
  final int _deckSize;

  Deck(this._deckSize);

  @override
  _DeckState createState() => _DeckState(this._deckSize);
}

class _DeckState extends State<Deck> {
  final int _deckSize;
  int _turnsLeft = 0;
  int _restsLeft = 0;
  int _discarded = 0;
  int _lost = 0;

  // keeps track of the first action on the turn while the second is being selected
  int firstAction = 0;

  bool editting = false;

  // Need a back button

  _DeckState(this._deckSize);

  @override
  void initState() {
    if (_deckSize < 2) {
      _turnsLeft = 0;
      _restsLeft = 0;
    } else {
      _turnsLeft = calculateTurnsLeft();
      _restsLeft = calculateRestsLeft();
    }
    super.initState();
  }

  int calculateTurnsLeft() {
    int turns = ((_deckSize - _lost - _discarded) / 2).floor();
    int i = 2;
    while (i <= (_deckSize - _lost - 1)) {
      turns += (i / 2).floor();
      i++;
    }

    return turns;
  }

  int calculateRestsLeft() {
    // Annoying edge cases
    if (_lost >= _deckSize - 1 || (_lost == _deckSize - 2 && _discarded == 1))
      return 0;
    else
      return _deckSize - _lost - 1;
  }

  List<int> calculateTurn(int lost, int discarded) {
    int newTurns = ((_deckSize - lost - discarded) / 2).floor();
    int i = 2;
    while (i <= (_deckSize - lost - 1)) {
      newTurns += (i / 2).floor();
      i++;
    }

    int newRests = _deckSize - lost - 1;
    // Annoying edge cases
    if (lost >= _deckSize - 1 || (lost == _deckSize - 2 && discarded == 1))
      newRests = 0;

    return [newTurns, newRests];
  }

  void chooseAction(int action) {
    if (firstAction == 0)
      firstAction = action;
    else {
      int newDiscarded = _discarded;
      int newLost = _lost;

      if (firstAction == 1)
        newDiscarded += 1;
      else
        newLost += 1;

      if (action == 1)
        newDiscarded += 1;
      else
        newLost += 1;

      int turnCost = _turnsLeft - calculateTurn(newLost, newDiscarded)[0];
      int restCost = _restsLeft - calculateTurn(newLost, newDiscarded)[1];

      _showDialog(turnCost, restCost, newDiscarded, newLost);
      firstAction = 0;
    }
  }

  chooseRest() {
    int newLost = _lost + 1;
    int newDiscarded = 0;
    int turnCost = _turnsLeft - calculateTurn(newLost, newDiscarded)[0];
    int restCost = _restsLeft - calculateTurn(newLost, newDiscarded)[1];

    _showDialog(turnCost, restCost, newDiscarded, newLost);
    firstAction = 0;
  }

  void _showDialog(int turnCost, int restCost, int newDiscarded, int newLost) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Cost",
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("$turnCost turn(s)"),
              Text("$restCost rest(s)"),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                setState(() {
                  _discarded = newDiscarded;
                  _lost = newLost;
                  _turnsLeft = calculateTurnsLeft();
                  _restsLeft = calculateRestsLeft();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Hello!",
          ),
          content: new Text(
              "• In Gloomhaven our health is really just how many turns we have left to play before we become exhausted.\n• There are three types of cards you can play on a turn: Discard cards, Lost cards, and Active cards.\n• Press the types of cards you plan on playing this turn and the app will tell you how many turns/rests (health) it will cost.\n• Use the edit function to fix the discard and lost pile sizes for abnormal turns.\n• Active cards should be considered lost until they are discarded, then use the edit function to fix the pile sizes (this might give you back some turns!)."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Max Turns Left",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "$_turnsLeft",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Max Rests Left",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          "$_restsLeft",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Discarded",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: 96,
                          child: RaisedButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (editting)
                                  IconButton(
                                    icon: Icon(Icons.arrow_upward),
                                    iconSize: 20,
                                    onPressed: () {
                                      setState(() {
                                        if ((_lost + _discarded) < _deckSize) {
                                          _discarded += 1;
                                          _turnsLeft = calculateTurnsLeft();
                                          _restsLeft = calculateRestsLeft();
                                        }
                                      });
                                    },
                                  ),
                                Text(
                                  "$_discarded",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                if (editting)
                                  IconButton(
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 20,
                                    onPressed: () {
                                      setState(() {
                                        if (_discarded > 0) {
                                          _discarded -= 1;
                                          _turnsLeft = calculateTurnsLeft();
                                          _restsLeft = calculateRestsLeft();
                                        }
                                      });
                                    },
                                  ),
                              ],
                            ),
                            onPressed: ((_lost + _discarded) < _deckSize - 1 &&
                                    !editting)
                                ? () {
                                    // If you have at least two cards in your hand
                                    chooseAction(1);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 40),
                    Column(
                      children: [
                        Text(
                          "Lost",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 150,
                          width: 96,
                          child: RaisedButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (editting)
                                  IconButton(
                                    icon: Icon(Icons.arrow_upward),
                                    iconSize: 20,
                                    onPressed: () {
                                      setState(() {
                                        if ((_lost + _discarded) < _deckSize) {
                                          _lost += 1;
                                          _turnsLeft = calculateTurnsLeft();
                                          _restsLeft = calculateRestsLeft();
                                        }
                                      });
                                    },
                                  ),
                                Text(
                                  "$_lost",
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                if (editting)
                                  IconButton(
                                    icon: Icon(Icons.arrow_downward),
                                    iconSize: 20,
                                    onPressed: () {
                                      setState(() {
                                        if (_lost > 0) {
                                          _lost -= 1;
                                          _turnsLeft = calculateTurnsLeft();
                                          _restsLeft = calculateRestsLeft();
                                        }
                                      });
                                    },
                                  ),
                              ],
                            ),
                            onPressed: ((_lost + _discarded) < _deckSize - 1 &&
                                    !editting)
                                ? () {
                                    // Make sure we have at least two cards in our hand
                                    chooseAction(2);
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 50),
                    Container(
                      height: 70,
                      width: 122,
                      child: RaisedButton(
                        child: Center(
                          child: Text(
                            "Rest",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        onPressed: (_discarded >= 2 && !editting)
                            ? () {
                                setState(() {
                                  // If there's two or more cards in the discard pile
                                  chooseRest();
                                });
                              }
                            : null,
                      ),
                    ),
                    SizedBox(width: 40),
                    Container(
                      height: 70,
                      width: 70,
                      child: RaisedButton(
                        child: Center(
                          child: Text(
                            "Edit",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            editting = !editting;
                            // Added this but havent tested it, seems innocuos though.
                            firstAction = 0;
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: 50,
                      height: 70,
                      child: GestureDetector(
                        onTap: () {
                          _showInfoDialog();
                        },
                        child: Icon(
                          Icons.info_outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
