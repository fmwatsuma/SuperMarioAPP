import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:super_mario2_app/button.dart';
import 'package:super_mario2_app/mario.dart';
import 'package:super_mario2_app/mushroom.dart';

import 'jumpingmario.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// for marios main axis position

  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;
  double shroomX = 0.5;
  double shroomY = 1;

  // for jumping functions
  double time = 0;
  double height = 0;
  double initialHeight = marioY;
  String direction = "right";
  bool midrun = false;
  bool midjump = false;
  void ateMushrooms() {
    if ((marioX - shroomX).abs() < 0.05 && (marioY - shroomY < 0.05)) {
      setState(() {
        // if eaten move the shroom off the screen-disappers in x-axis
        shroomX = 2;
        marioSize = 100; // after eating mushroom he becomes twice as big
      });
    }
  }

  // -1 is beginning of x-axis
  //  0 is the middle of x-axis
  //  1 is the end of x-axis

  // jumping functions

  void preJump()
// sets the initial height before jumping
  {
    time = 0;
    initialHeight = marioY;
  }

  void jump() {
    // disables double jump
    if (midjump == false) {
      midjump = true;
      preJump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        // quadratic equation to beat gravity
        //used in fluppy bird

        // every time you click jump it increases by 0.05
        time += 0.05;
        height = -4.9 * time * time + 5 * time;

        if (initialHeight - height > 1) {
          midjump = false;

          // rebuild the widget with new values
          setState(() {
            marioY = 1;
          });
          timer.cancel(); // cancel  timer after jumping

        } else {
          setState(() {
            marioY = initialHeight - height;
          });
        }
      });
    }
  }

//Moving right function +=0.02
  // moving right is  positive

  void moveRight() {
    direction = "right";
    ateMushrooms();

    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true&& (marioX + 0.02)<1 ) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  //Moving Left function -=0.02
  // moving left is negative

  void moveLeft() {
    direction = "left";
    ateMushrooms();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (MyButton().userIsHoldingButton() == true && (marioX - 0.02)>-1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // contains  the colors
      body: Column(
        children: [
          Expanded(

              ///  size of the container
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      // positioning of mario

                      // y and x axis
                      alignment: Alignment(marioX, marioY),
                      duration: Duration(milliseconds: 0),
                      child: midjump
                          ? JumpingMario(
                              direction: direction,
                              size: marioSize,
                            )
                          : Mario(
                              direction: direction,
                              midrun: midrun,
                              size: marioSize,
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(shroomX,
                        shroomY), //position of the mushroom along the y and x-axis
                    child: Mushroom(),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Mario",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text("00000",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "World",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text("1-1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                            ],
                          ),
                          Column(
                            children: [
                              Text("Time",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text("9999",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white)),
                            ],
                          )
                        ],
                      ))
                ],
              )),
          Expanded(
              // size of the container
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  // specicify positioning of arrows
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  //specify the arrows
                  children: [
                    MyButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      function: moveLeft,
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                      function: jump,
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      function: moveRight,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
