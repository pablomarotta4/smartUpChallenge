// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:provider/provider.dart';

class EnterPasswordPage extends StatefulWidget {
  final String loginFactor;
  const EnterPasswordPage({super.key, required this.loginFactor});

  @override
  _EnterPasswordPageState createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String? _errorText;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _handleLogin() async {
    final auth = Provider.of<AuthController>(context, listen: false);


    try {
        UserCredential loginSuccess;
        if (widget.loginFactor.contains('@')) {
          loginSuccess = await auth.signInWithEmailAndPassword(
          email: widget.loginFactor,
          password: _passwordController.text,
        );
      } else if (RegExp(r'^\+?[0-9]{10,15}$').hasMatch(widget.loginFactor)) {
        // lógica de inicio de sesión con número de teléfono
        return;
      } else {
          loginSuccess = await auth.signInWithEmailAndPassword(
          email:  await auth.getUserMailWithUsername(username: widget.loginFactor),
          password: _passwordController.text,
        );
      }
    

      _navigateToHome();
    } catch (e) {
      _setErrorText('Error logging in. Please try again.');
    }
  }

  void _navigateToHome() {
    setState(() {
      _errorText = null;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  }

  void _setErrorText(String error) {
    setState(() {
      _errorText = error;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 23, 24),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(showButton: true, iconType: 'close'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "Enter your password",
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
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
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
            const SizedBox(height: 10), 
            Expanded(
              child: Container(),
            ),
            const CustomDivider(thickness: 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LoginFooter(
                buttonType: 'login',
                onPressed: _handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
