// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/screens/login/loginPasswordStep.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/controllers/authController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    String input = _controller.text.trim();
    final auth = Provider.of<AuthController>(context, listen: false);

    try {
      bool exists = await auth.checkIfUserExist(
        input: input,
      );

      if (exists) {
        _navigateToEnterPasswordPage(input);
      } else {
        _setErrorText('The account does not exist.');
      }
    } catch (e) {
      _setErrorText('An error occurred. Please try again.');
    }
  }

  void _navigateToEnterPasswordPage(String input) {
    setState(() {
      _errorText = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterPasswordPage(loginFactor: input),
      ),
    );
  }

  void _setErrorText(String error) {
    setState(() {
      _errorText = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderWidget(showButton: true, iconType: 'close'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "To get started, first enter your phone, email, or @username",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Phone, email, or username',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorText: _errorText,
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const CustomDivider(thickness: 0.01),
            LoginFooter(
              buttonType: 'next',
              onPressed: _handleNext,
            ),
          ],
        ),
      ),
    );
  }
}
