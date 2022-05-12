import 'package:flutter/material.dart';

import '../custom/symbolo.dart';
import '../custom/symbolx.dart';
import '../theme/theme.dart';
import 'game_page.dart';
import '../custom/circlePainter.dart';
import '../custom/circlewave.dart';


class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  final double size = 80.0;
  final Color color = MyTheme.yellow;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _playButton() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                widget.color,
                Color.lerp(widget.color, Colors.black, .05)!
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child:

              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GamePage()));
                },

                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: MyTheme.green,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Text(
                      "PLAY",
                      style: TextStyle(
                          fontSize: 30,
                          color: MyTheme.kTextWhiteColor,
                          fontFamily: 'Mazzard',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),

              )

          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          children: <Widget>[
            Wrap(direction: Axis.horizontal, children: <Widget>[
              Center(
                child: Hero(
                    tag: 'imageHero',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        O(77, MyTheme.green),
                        X(80, 20),

                      ],
                    )),
              ),
            ]),
            // const Text("Welcome to Flutter Tic Tac Toe!", style: TextStyle(fontSize: 20),),

            Center(
              child: CustomPaint(
                painter: CirclePainter(
                  _controller,
                  color: widget.color,
                ),
                child: SizedBox(
                  width: widget.size * 4.125,
                  height: widget.size * 4.125,
                  child: _playButton(),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}