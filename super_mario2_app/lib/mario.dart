import 'dart:math';

import 'package:flutter/material.dart';

class Mario extends StatelessWidget {
  final direction;
  final midrun;
  final size;

  Mario({this.direction, this.midrun,this.size});
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(

          // size of mario
          width: size,
          height: size,
          child: midrun // transition while standing and running
              ? Image.asset("assets/standingmario.png")
              : Image.asset("assets/running.png"));
    } else {
// to change  mario's direction whenever he turns left or right
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(

            // size of mario

            width: size,
            height: size,
            child: midrun
                ? Image.asset("assets/standingmario.png")
                : Image.asset("assets/running.png")),
      );
    }
  }
}
