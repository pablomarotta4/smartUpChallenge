import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/screens/login/loginPasswordStep.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/controllers/authController.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _handleNext() async {
    String input = _controller.text.trim();
    final auth = Provider.of<AuthController>(context, listen: false);

    try {
      bool exists = await auth.checkIfEmailOrPhoneOrUsernameExists(
        email: input,
        phone: input,
        username: input,
      );

      setState(() {
        if (exists) {
          _errorText = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EnterPasswordPage(loginFactor: input),
            ),
          );
        } else {
          _errorText = 'The account does not exist.';
        }
      });
    } catch (e) {
      setState(() {
        _errorText = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(showButton: true, iconType: 'close'),
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
            CustomDivider(),
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
