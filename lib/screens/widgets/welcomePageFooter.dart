import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/login.dart'; 

class WelcomePageFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Asegura que los elementos en la columna estén alineados a la izquierda
        children: [
          RichText(
            textAlign: TextAlign.left, // Alinea el texto a la izquierda
            text: TextSpan(
              text: 'Have an account already? ',
              style: const TextStyle(color: Colors.grey, fontSize: 10),
              children: <TextSpan>[
                TextSpan(
                  text: 'Log In',
                  style: const TextStyle(color: Colors.blue, fontSize: 10),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
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
