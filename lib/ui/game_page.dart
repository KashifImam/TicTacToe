import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tictactoerapidor/ui/final_page.dart';

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

class GamePageState extends State<GamePage> with TickerProviderStateMixin{
  late List<int> board;
  late int _currentPlayer;

  late GamePresenter _presenter;

  int yourWins = 0;
  int comWins = 0;

  GamePageState() {
    _presenter = GamePresenter(_movePlayed, _onGameEnd);
  }

  void showBottomSheet(BuildContext context, int type, String title, String content) {
    AnimationController controller;
    controller = BottomSheet.createAnimationController(this);
    controller.duration = Duration(milliseconds: 600);

    showModalBottomSheet(
        context: context,
        transitionAnimationController: controller,
        // isScrollControlled: true,
        isDismissible: false,
        isScrollControlled: false,
        builder: (context) => GestureDetector(
          child: FractionallySizedBox(
            // heightFactor: 0.7,
            child: FinalPage(type: type, title: title, content: content),
          ),
          onVerticalDragStart: (_) {},
        ));


    // builder: (BuildContext buildContext) => BottomActivateAcc());
  }

  void _onGameEnd(int winner) {

    setState(() {
      reinitialize();
    });

    var title = "Game over!";
    var content = "You lose ☹";
    switch (winner) {

      case Ai.HUMAN:
        title = "Congratulations!";
        content = "You managed to beat an unbeatable AI!";
        yourWins = yourWins + 1;
        break;
      case Ai.AI_PLAYER:
        title = "Game Over!";
        content = "You lose ☹";
        comWins = comWins + 1;
        break;
      default:
        title = "Game Draw!";
        content = "No winners here ☻";
    }
    showBottomSheet(context, winner, title, content);

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

    final double itemHeight = (height * 0.64) / 3.0;
    final double itemWidth = width / 3;

    return Scaffold(
      backgroundColor: MyTheme.bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.refresh,
                color: MyTheme.kTextWhiteColor,
              ),
              onPressed: () {
                yourWins = 0;
                comWins = 0;
                setState(() {
                  reinitialize();
                });
              }),
        ],
        backgroundColor: MyTheme.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            NeumorphicText(
              "  TIC",
              style: const NeumorphicStyle(
                  color: MyTheme.pink,
                  lightSource: LightSource.left,
                  depth: 3,
                  shadowDarkColor: MyTheme.yellow,
                  shadowLightColor: MyTheme.yellow,
                  border: NeumorphicBorder(
                    color: MyTheme.yellow,
                    width: 0.4,

                  )),
              textStyle: NeumorphicTextStyle(
                fontSize: 24,


                  fontFamily: 'Mazzard',
                  fontWeight: FontWeight.bold

                //customize size here
                // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
            ),
            NeumorphicText(
              " TAC",
              style: const NeumorphicStyle(
                  color: MyTheme.pink,
                  lightSource: LightSource.left,
                  depth: 3,
                  shadowDarkColor: MyTheme.yellow,
                  shadowLightColor: MyTheme.yellow,
                  border: NeumorphicBorder(
                    color: MyTheme.yellow,
                    width: 0.4,
                  )),
              textStyle: NeumorphicTextStyle(
                fontSize: 24,
                  fontFamily: 'Mazzard',
                  fontWeight: FontWeight.bold//customize size here
                // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
            ),
            NeumorphicText(
              " TOE",
              style: const NeumorphicStyle(
                  color: MyTheme.pink,
                  lightSource: LightSource.left,
                  depth: 3,
                  shadowDarkColor: MyTheme.yellow,
                  shadowLightColor: MyTheme.yellow,
                  border: NeumorphicBorder(
                    color: MyTheme.yellow,
                    width: 0.4,
                  )),
              textStyle: NeumorphicTextStyle(
                fontSize: 24,
                  fontFamily: 'Mazzard',
                  fontWeight: FontWeight.bold//customize size here
                // AND others usual text style properties (fontFamily, fontWeight, ...)
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyTheme.gredColor2, MyTheme.gredColor1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
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
                              color: MyTheme.kTextWhiteColor,
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
                              color: MyTheme.kTextWhiteColor,
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
            SizedBox(
              // color: MyTheme.lightBlueBack,
              // color: MyTheme.lightBlueBack,
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
                      children: [
                        Text(
                          "${yourWins}",
                          style: const TextStyle(
                              fontSize: 36,
                              color: MyTheme.yellow,
                              fontFamily: 'Mazzard',
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Your Wins",
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme.kTextWhiteColor,
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
                      children: [
                        Text(
                          "$comWins",
                          style: const TextStyle(
                              fontSize: 36,
                              color: MyTheme.green,
                              fontFamily: 'Mazzard',
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Computer's Wins",
                          style: TextStyle(
                              fontSize: 14,
                              color: MyTheme.kTextWhiteColor,
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
      ),
    );
  }


}
