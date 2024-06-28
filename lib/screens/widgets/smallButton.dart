import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String buttonType; 
  final VoidCallback onPressed;

  SmallButton({Key? key, required this.buttonType, required this.onPressed}) : super(key: key);

  final Map<String, dynamic> buttonsData = {
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
  };

  @override
  Widget build(BuildContext context) {
    final buttonData = buttonsData[buttonType]!;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(buttonData['color']),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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
