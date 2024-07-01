// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String buttonType;
  final VoidCallback onPressed;

  const SmallButton({super.key, required this.buttonType, required this.onPressed});

  static const Map<String, dynamic> buttonsData = {
    'next': {
      'text': 'Next',
      'color': Color.fromARGB(255, 29, 161, 242),
      'textColor': Colors.white,
    },
    'login': {
      'text': 'Log in',
      'color': Color.fromARGB(255, 29, 161, 242),
      'textColor': Colors.white,
    },
    'register': {
      'text': 'Register',
      'color': Color.fromARGB(255, 29, 161, 242),
      'textColor': Colors.white,
    },
    'post': {
      'text': 'Post',
      'color': Color.fromARGB(255, 29, 161, 242),
      'textColor': Colors.white,
    },
  };

  @override
  Widget build(BuildContext context) {
    final buttonData = buttonsData[buttonType]!;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(buttonData['color']),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        ),
      ),
      child: Text(
        buttonData['text'],
        style: TextStyle(
          color: buttonData['textColor'],
          fontSize: 13,
        ),
      ),
    );
  }
}
