import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoerapidor/theme/theme.dart';
import 'package:tictactoerapidor/ui/home_page.dart';

import '../custom/symbolo.dart';
import '../custom/symbolx.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  bool isLoading = false;

  late Animation _arrowAnimation;
  late AnimationController _arrowAnimationController;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [MyTheme.gredColor2, MyTheme.gredColor1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

        ),
      ),

      child: Center(
        child: Wrap(direction: Axis.horizontal, children: <Widget>[
          Center(
            child: Hero(
                tag: 'imageHero',
                child: Row(
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
                )),
          ),
        ]),
      ),
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
      navigate();
    });
  }

  navigate() async {
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
        transitionDuration: Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var curve = Curves.ease;

          var tween = Tween(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        });
  }
}
