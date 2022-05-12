import 'package:flutter/material.dart';

import '../ai/ai.dart';
import '../custom/symbolo.dart';
import '../custom/symbolx.dart';
import '../theme/theme.dart';
import 'field.dart';
import 'game_presenter.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);




  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  late List<int> board;
  late int _currentPlayer;

  late GamePresenter _presenter;

  int yourWins = 0;
  int comWins = 0;

  GamePageState() {
    _presenter = GamePresenter(_movePlayed, _onGameEnd);
  }

  void _onGameEnd(int winner) {
    var title = "Game over!";
    var content = "You lose :(";
    switch (winner) {
      case Ai.HUMAN: // will never happen :)
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        yourWins = yourWins + 1;
        break;
      case Ai.AI_PLAYER:
        title = "Game Over!";
        content = "You lose :(";
        comWins = comWins + 1;
        break;
      default:
        title = "Draw!";
        content = "No winners here.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    setState(() {
                      reinitialize();
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("Restart"))
            ],
          );
        });
  }

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      if (_currentPlayer == Ai.HUMAN) {
        // switch to AI player
        _currentPlayer = Ai.AI_PLAYER;
        _presenter.onHumanPlayed(board);
      } else {
        _currentPlayer = Ai.HUMAN;
      }
    });
  }

  String? getSymbolForIdx(int idx) {
    return Ai.SYMBOLS[board[idx]];
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = Ai.HUMAN;
    // generate the initial board
    board = List.generate(9, (idx) => 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom) -
        kToolbarHeight;

    final double itemHeight = (height * 0.64)/3.0;
    final double itemWidth = width / 3;

    return Scaffold(
      backgroundColor: MyTheme.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.refresh,
          color: MyTheme.pink,), onPressed: () {
            yourWins = 0;
            comWins = 0;
            setState(() {
              reinitialize();
            });

          }),
        ],
        backgroundColor: MyTheme.bgColor,
        title: RichText(
          textAlign: TextAlign.start,
          text: const TextSpan(

            children: [
              TextSpan(
                text: "Tic",
                style:  TextStyle(
                    fontSize: 24,
                    color: MyTheme.blue,
                    fontFamily: 'Mazzard',
                    fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: " Tac",
                style:  TextStyle(
                    fontSize: 24,
                    color: MyTheme.pink,
                    fontFamily: 'Mazzard',
                    fontWeight: FontWeight.normal),
              ),
              TextSpan(
                text: " Toe",
                style:  TextStyle(
                    fontSize: 24,
                    color: MyTheme.blue,
                    fontFamily: 'Mazzard',
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: height * 0.18,
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "You are",
                        style: TextStyle(
                            fontSize: 16,
                            color: MyTheme.pink,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      X(32, 10)
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Computer",
                        style: TextStyle(
                            fontSize: 16,
                            color: MyTheme.blue,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      O(32, MyTheme.green),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: MyTheme.lightBlueBack,
            height: height * 0.64,
            child: GridView.count(
              shrinkWrap: true,
              controller: new ScrollController(keepScrollOffset: false),
              // childAspectRatio: 0.9,
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 3,

              // generate the widgets that will display the board
              children: List.generate(9, (idx) {
                return Field(
                    idx: idx,
                    onTap: _movePlayed,
                    playerSymbol: getSymbolForIdx(idx)!);
              }),
            ),
          ),
          Container(
            height: height * 0.18,
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,

              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        "${yourWins}",
                        style: const TextStyle(
                            fontSize: 36,
                            color: MyTheme.pink,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),

                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Your Wins",
                        style: TextStyle(
                            fontSize: 14,
                            color: MyTheme.kTextDarkColor,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text(
                        "$comWins",
                        style: const TextStyle(
                            fontSize: 36,
                            color: MyTheme.blue,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 4,
                      ),

                      const Text(
                        "Computer's Wins",
                        style: TextStyle(
                            fontSize: 14,
                            color: MyTheme.kTextDarkColor,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
