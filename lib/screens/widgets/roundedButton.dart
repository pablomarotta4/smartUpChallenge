
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonType;
  final VoidCallback onPressed;

  RoundedButton({Key? key, required this.buttonType, required this.onPressed}) : super(key: key);

  final Map<String, dynamic> buttonsData = {
    'google': {
      'text': 'Continue with Google',
      'color': Colors.white,
      'textColor': Colors.black,
      'icon': 'assets/icons/google.png',
    },
    'createAccount': {
      'text': 'Create account',
      'color': Color.fromARGB(255, 29, 161, 242),
      'textColor': Colors.white,
      'icon': null,
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
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonData['icon'] != null) ...[
              Image.asset(buttonData['icon'], height: 18, width: 18),
              SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                buttonData['text'],
                style: TextStyle(
                  color: buttonData['textColor'],
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
