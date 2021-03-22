import 'dart:math';

import 'package:flutter/cupertino.dart';

class JumpingMario extends StatelessWidget {
  final direction;
  final size;
  JumpingMario({this.direction,this.size});
  @override
  Widget build(BuildContext context) {
    if (direction == "right") {
      return Container(
        width: size,
        height: size,
        child: Image.asset("assets/jumping mario.png"),
      );
    } else {
      return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.rotationY(pi), // rotation while jumping facing left
          child: Container(
            width: size,
            height: size,
            child: Image.asset("assets/jumping mario.png"),
          ));
    }
  }
}
