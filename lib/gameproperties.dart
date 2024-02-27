import 'package:flutter/material.dart';



class GameProperties {
  int height, width, timerDuration;
  Color onColor, offColor;
  List<int> survive, born;
  bool grilleStartEmpty;

  GameProperties(
    this.height,
    this.width,
    this.timerDuration,
    this.onColor,
    this.offColor,
    this.survive,
    this.born,
    this.grilleStartEmpty
  );
}