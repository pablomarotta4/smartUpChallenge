// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/registerFooter.dart';

class RegisterPasswordStep extends StatefulWidget {
  final String name;
  final String emailOrPhone;
  final String birth;

  const RegisterPasswordStep({
    super.key,
    required this.name,
    required this.emailOrPhone,
    required this.birth,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPasswordStepState createState() => _RegisterPasswordStepState();
}

class _RegisterPasswordStepState extends State<RegisterPasswordStep> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _errorText;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _handleRegister(BuildContext context) async {
    final auth = Provider.of<AuthController>(context, listen: false);
    String password = _passwordController.text;

    try {
      UserCredential? userCredential = await auth.createAccount(
        emailOrPhone: widget.emailOrPhone,
        username: widget.name,
        password: password,
        birth: widget.birth,
        context: context,
      );

      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        _setErrorText('Error creating account');
      }
    } catch (e) {
      _setErrorText('Error creating account: $e');
    }
  }

  void _setErrorText(String error) {
    setState(() {
      _errorText = error;
    });
  }

  void _handleSubmit() {
    if (widget.emailOrPhone.contains('@') || widget.emailOrPhone.contains('+')) {
      _handleRegister(context);
    } else {
      _setErrorText('Invalid email or phone number');
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(showButton: true, iconType: 'back'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "Create a password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorText: _errorText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            const CustomDivider(thickness: 0.01),
            RegisterFooter(
              buttonType: 'register',
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
