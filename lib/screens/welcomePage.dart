import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/roundedButton.dart';
import 'package:smartup_challenge/screens/widgets/welcomePageFooter.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(showButton: false),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0), 
                    child: Text(
                      "See what's happening in the world right now.",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify, 
                    ),
                  ),
                  const Spacer(),
                  RoundedButton(
                    buttonType: 'google',
                    onPressed: () {
                      // Acción para el botón de Google
                    },
                  ),
                  SizedBox(height: 10),
                  const Text(
                    "Or",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  RoundedButton(
                    buttonType: 'createAccount',
                    onPressed: () {
                      // Acción para el botón de crear cuenta
                    },
                  ),
                  SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
                      children: [
                        Text(
                          "By signing up, you agree to our ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Terms of Service ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ", ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Privacy Policy ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          ", ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "and ",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Cookie Use.",
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  WelcomePageFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
