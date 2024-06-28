import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/smallButton.dart';

class RegisterFooter extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonType;

  const RegisterFooter({required this.onPressed, required this.buttonType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SmallButton(
            onPressed: onPressed,
            buttonType: buttonType,
          ),
        ],
      ),
    );
  }
}
