import "package:flutter/material.dart";
import "package:game_of_life/grille.dart";
import "dart:async";
import "package:game_of_life/gameproperties.dart";

class CurrentGame extends StatefulWidget {
  GameProperties gameProperties;

  CurrentGame(this.gameProperties, {super.key});

  @override
  State<CurrentGame> createState() => CurrentGameState(gameProperties);
}

class CurrentGameState extends State<CurrentGame> {
  GameProperties gameProperties;
  late Grille grille;
  late Timer timer;
  bool ignore;

  CurrentGameState(this.gameProperties)
    : grille = gameProperties.grilleStartEmpty
        ? Grille.empty(gameProperties.width, gameProperties.height)
        : Grille.randomize(gameProperties.width, gameProperties.height),
      ignore = gameProperties.grilleStartEmpty;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: gameProperties.timerDuration), (_) =>
      setState(() => grille.update([2, 3], [3], ignore))
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var entireGrid = [
      for (var yB = 0; yB < grille.height; yB++) 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var xB = 0; xB < grille.width; xB++) 
              Container(
                height: 10,
                width: 10,
                color: grille.values[yB][xB] ? gameProperties.onColor : gameProperties.offColor,
                child : GestureDetector(
                  onTap: () => setState(() => grille.values[yB][xB] = !grille.values[yB][xB]),
                )
              )
          ],
        )
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: entireGrid,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () => setState(() => ignore = !ignore),
          style: ButtonStyle(
            iconColor: MaterialStateProperty.resolveWith((_)
              => ignore ? Colors.yellow : Colors.white
            ),
            side: MaterialStateProperty.resolveWith((states) => BorderSide(
              color: ignore ? Colors.yellow : Colors.white,
              width: states.contains(MaterialState.hovered) ? 5 : 1
            ))
          )
        )
      ]
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}