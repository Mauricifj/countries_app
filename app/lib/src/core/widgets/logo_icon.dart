import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  final double size;

  const LogoIcon({
    super.key,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/launch_icon.png',
      height: size,
      width: size,
    );
  }
}
