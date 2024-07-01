// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlyingDrawerButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FlyingDrawerButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue,
      child: const FaIcon(
        FontAwesomeIcons.featherAlt,
        color: Colors.white,
      ),
    );
  }
}
