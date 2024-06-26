import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/smallButton.dart';

class LoginFooter extends StatelessWidget {
  final String buttonType;
  final VoidCallback onPressed;

  const LoginFooter({required this.buttonType, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Forgot password?", style: TextStyle( color: Colors.blue)),
          const SizedBox(width: 10),
          SmallButton(buttonType: buttonType, onPressed: onPressed),
        ],
      ),
    );
  }
}
