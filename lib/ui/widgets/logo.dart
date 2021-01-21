import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  const AppLogo({Key key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/app_logo.png",
      height: height,
    );
  }
}
