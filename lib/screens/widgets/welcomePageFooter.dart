import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/login/login.dart'; 

class WelcomePageFooter extends StatelessWidget {
  const WelcomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left, 
            text: TextSpan(
              text: 'Have an account already? ',
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              children: <TextSpan>[
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(color: Colors.blue, fontSize: 11),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
