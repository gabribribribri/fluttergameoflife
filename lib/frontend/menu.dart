import "package:flutter/material.dart";
import "package:game_of_life/frontend/currentgame.dart";
import "package:game_of_life/frontend/pagesurronder.dart";
import "package:game_of_life/gameproperties.dart";

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  GameProperties gameProperties = GameProperties(
    45, 65, 1000,
    Colors.yellow,
    Colors.transparent,
    [2, 3], [3],
    false
  );

  Text settingsText(String parameterText) {
    return Text(
      parameterText,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w100
      ),
    );
  }

  Row settingsSliderRow(
    String parameterText,
    double sliderValue,
    void Function(double)? sliderOnChanged,
    double sliderMin,
    double sliderMax
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        settingsText(parameterText),
        Slider(
          activeColor: Colors.yellow,
          value: sliderValue,
          onChanged: sliderOnChanged,
          min: sliderMin,
          max: sliderMax
        )
      ],
    );
  }

  Row settingsSwitchRow(
    String parameterText,
    bool switchValue,
    void Function(bool)? switchOnChanged
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        settingsText(parameterText),
        Switch(
          activeColor: Colors.yellow,
          value: switchValue,
          onChanged: switchOnChanged
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          settingsSliderRow(
            "Width",
            gameProperties.width.toDouble(),
            (value) => setState(() => gameProperties.width = value.round()),
            5,
            130
          ),
          settingsSliderRow(
            "Height",
            gameProperties.height.toDouble(),
            (value) => setState(() => gameProperties.height = value.round()),
            5,
            65
          ),
          settingsSliderRow(
            "Generation Duration",
            gameProperties.timerDuration.toDouble(),
            (value) => setState(() => gameProperties.timerDuration = value.round()),
            50,
            2000
          ),
          settingsSwitchRow(
            gameProperties.grilleStartEmpty ? "Empty Grille" : "Randomize Grille",
            !gameProperties.grilleStartEmpty,
            (value) => setState(() => gameProperties.grilleStartEmpty = !value)
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                PageSurronder(CurrentGame(gameProperties))
              ));
            },
            icon: Icon(Icons.play_arrow),
            style: ButtonStyle(
              iconColor: MaterialStateProperty.resolveWith((_) => Colors.black),
              backgroundColor: MaterialStateProperty.resolveWith((states)
                => states.contains(MaterialState.hovered)
                  ? Colors.white
                  : Color.fromRGBO(225, 241, 75, 0.992)
              )
            ),
          )
        ],
      ),
    );
  }
}