import 'dart:math';

import 'package:flutter/material.dart';

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
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: 30,
                          color: MyTheme.kTextDarkColor,
                          fontFamily: 'Mazzard',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                    child: Text(
                      widget.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Mazzard',
                        color: MyTheme.kTextDarkColor,
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
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);

    _arrowAnimationController.forward();

    Future.delayed(const Duration(seconds: 3)).then((_) {
      _arrowAnimationController.reverse();

    });
  }


  void _handleSubmitted() async {
    Navigator.pop(context);
  }
}
