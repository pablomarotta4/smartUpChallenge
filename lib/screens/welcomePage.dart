import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/roundedButton.dart';
import 'package:smartup_challenge/screens/widgets/welcomePageFooter.dart';
import 'package:smartup_challenge/screens/register.dart';
import 'package:smartup_challenge/screens/authenticate/autenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Authenticate _auth = Authenticate();
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

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
                    onPressed: () async {
                      User? user = await _auth.signInWithGoogle();
                      if (user != null) {
                      } else {
                      }
                    },
                  ),
                  const SizedBox(height: 10),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Register()),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  const WelcomePageFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
