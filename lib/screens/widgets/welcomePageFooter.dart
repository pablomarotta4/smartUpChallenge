import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/login/login.dart'; 

class WelcomePageFooter extends StatelessWidget {
  const WelcomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: <Widget>[
          RichText(
            textAlign: TextAlign.start, 
            text: TextSpan(
              text: 'Have an account already? ',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              children: <TextSpan>[
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(color: Colors.blue, fontSize: 12),
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
