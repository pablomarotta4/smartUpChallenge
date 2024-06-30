// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/roundedButton.dart';
import 'package:smartup_challenge/screens/widgets/welcomePageFooter.dart';
import 'package:smartup_challenge/screens/register/register.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthController>(context, listen: false);
    auth.authStateChanges().listen((User? user) {
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthController>(context);

    return Scaffold(
      extendBody: true, 
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(showButton: false),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      "See what's happening in the world right now.",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const Spacer(),
                    RoundedButton(
                      buttonType: 'google',
                      onPressed: () async {
                        try {
                          User? user = await auth.signInWithGoogle();
                          if (user != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const WelcomePage()),
                            );
                          }
                        } catch (e) {
                          print("Error signing in with Google: $e");
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RoundedButton(
                      buttonType: 'createAccount',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text.rich(
                        TextSpan(
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: "By signing up, you agree to our ",
                            ),
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text: ", ",
                            ),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text: ", and ",
                            ),
                            TextSpan(
                              text: "Cookie Use.",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const WelcomePageFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
