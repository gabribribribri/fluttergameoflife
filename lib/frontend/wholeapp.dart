import "package:flutter/material.dart";
import "package:game_of_life/frontend/pagesurronder.dart";
//import "package:game_of_life/frontend/currentgame.dart";
import "package:game_of_life/frontend/menu.dart";

class WholeApp extends StatelessWidget {
  const WholeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      initialRoute: "menu",
      routes: {
        "menu" : (_) => PageSurronder(Menu()),
        //"game" : (_) => const PageSurronder(CurrentGame())
      },
    );
  }
}