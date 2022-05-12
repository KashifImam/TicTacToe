import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:tictactoerapidor/ai/ai.dart';

import '../custom/symbolo.dart';
import '../custom/symbolx.dart';
import '../theme/theme.dart';

class FinalPage extends StatefulWidget {
  final int type;
  final String title;
  final String content;

  const FinalPage({Key? key, required this.type, required this.title, required this.content}) : super(key: key);

  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> with TickerProviderStateMixin {
  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyTheme.pink, MyTheme.yellow],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          ),
        ),
        child:

            SizedBox(
              height: 370,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      O(77, MyTheme.green),
                      AnimatedBuilder(
                        animation: _arrowAnimationController,
                        builder: (context, child) => Transform.rotate(
                          angle: _arrowAnimation.value,
                          child: X(80, 20),
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: NeumorphicText(
                      widget.title,
                      style: const NeumorphicStyle(
                          color: MyTheme.blue,
                          lightSource: LightSource.left,
                          depth: 9,
                          shadowDarkColor: MyTheme.green,
                          shadowLightColor: MyTheme.green,
                          border: NeumorphicBorder(
                            color: MyTheme.green,
                            width: 0.9,

                          )),
                      textStyle: NeumorphicTextStyle(
                          fontSize: 32,


                          fontFamily: 'Mazzard',
                          fontWeight: FontWeight.bold

                        //customize size here
                        // AND others usual text style properties (fontFamily, fontWeight, ...)
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Mazzard',
                        color: widget.type == Ai.HUMAN? MyTheme.green : MyTheme.blue ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: OutlinedButton(
                      onPressed: _handleSubmitted,
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(width.toDouble(), 50),
                        primary: MyTheme.kTextDarkColor,
                        backgroundColor: MyTheme.kTextDarkColor,
                      ),
                      child: Text(
                        'Play Again',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Mazzard',
                            fontWeight: FontWeight.normal,
                            color: MyTheme.green),
                      ),
                    ),
                  ),
                ],
              ),
            )

    );
  }

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _arrowAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_arrowAnimationController);

    _arrowAnimationController.repeat(reverse: true);

  }


  void _handleSubmitted() async {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }
}
