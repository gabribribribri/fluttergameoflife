import "package:flutter/material.dart";

class PageSurronder extends StatelessWidget {
  final Widget insider;
  const PageSurronder(this.insider, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(64, 64, 64, 1),
      body: Center(
        child: insider,
      ),
    );
  }
}
