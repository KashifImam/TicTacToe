import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../custom/symbolo.dart';
import '../custom/symbolx.dart';
import '../theme/theme.dart';

class Field extends StatelessWidget {

  final int idx;
  final Function(int idx) onTap;
  final String playerSymbol;


  Field({required this.idx, required this.onTap, required this.playerSymbol});

  final BorderSide _borderSide =  const BorderSide(
      color: MyTheme.kTextGreyColor,
      width: 0.5,
      style: BorderStyle.solid
  );

  void _handleTap() {
    // only send tap events if the field is empty
    if (playerSymbol == "") {
      onTap(idx);
    }
  }

  /// Returns a border to draw depending on this field index.
  Border _determineBorder() {
    Border determinedBorder = Border.all();
    determinedBorder = Border(bottom: _borderSide, right: _borderSide, top: _borderSide, left: _borderSide);

    return determinedBorder;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child:
      getSymbolBackground(playerSymbol)
    );
  }

  Widget getSymbolBackground (String selection){
    if (selection == "X"){

      return Container(
        decoration: BoxDecoration(
          border: _determineBorder(),
        ),
        child: Neumorphic(

          style: const NeumorphicStyle(
              color: MyTheme.pink,
              lightSource: LightSource.left,
              depth: 3,
              shadowDarkColor: MyTheme.yellow,
              shadowLightColor: MyTheme.yellow,
              border: NeumorphicBorder(
                color: MyTheme.yellow,
                width: 0.4,
              )
          ),
          margin: const EdgeInsets.all(6.0),

          child: Center(
            child: getSymbol(playerSymbol),
          ),
        ),
      );

    }else if (selection == "O"){
      return Container(
        decoration: BoxDecoration(
          border: _determineBorder(),
        ),
        child: Neumorphic(

          style: const NeumorphicStyle(
              color: MyTheme.blue,
              lightSource: LightSource.left,
              depth: 3,
              shadowDarkColor: MyTheme.green,
              shadowLightColor: MyTheme.green,
              border: NeumorphicBorder(
                color: MyTheme.green,
                width: 0.6,
              )
          ),
          margin: const EdgeInsets.all(6.0),

          child: Center(
            child: getSymbol(playerSymbol),
          ),
        ),
      );
    }
    else{
      return Container(

        margin: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          border: _determineBorder(),

        ),
        child: Center(
          child: getSymbol(playerSymbol),
        ),
      );
    }
  }
  Widget getSymbol (String selection){
    if (selection == "X"){
      return
        X(46, 13);

    }else if (selection == "O"){
      return O(46, MyTheme.green);
    }
    else{
      return SizedBox();
    }
  }


}