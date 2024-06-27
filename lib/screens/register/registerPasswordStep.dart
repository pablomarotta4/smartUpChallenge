import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:provider/provider.dart';

class RegisterPasswordStep extends StatefulWidget {
  final String name;
  final String emailOrPhone;
  final String birth;

  const RegisterPasswordStep({
    Key? key,
    required this.name,
    required this.emailOrPhone,
    required this.birth,
  }) : super(key: key);

  @override
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

  void _handleRegister() async {
    final auth = Provider.of<AuthController>(context, listen: false);
    String password = _passwordController.text;

    try {
      UserCredential? userCredential;

      if (widget.emailOrPhone.contains('@')) {
        userCredential = await auth.createAccount(
          email: widget.emailOrPhone,
          username: widget.name,
          password: password,
          birth: widget.birth,
        );
      } else {
        userCredential = await auth.createAccount(
          phone: widget.emailOrPhone,
          username: widget.name,
          password: password,
          birth: widget.birth,
        );
      }

      if (userCredential != null) {
        setState(() {
          _errorText = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        });
      } else {
        setState(() {
          _errorText = 'Error al crear la cuenta';
        });
      }
    } catch (e) {
      setState(() {
        _errorText = 'Error al crear la cuenta: $e';
      });
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
            HeaderWidget(showButton: true, iconType: 'back'),
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
            Expanded(
              child: Container(),
            ),
            LoginFooter(
              buttonType: 'register',
              onPressed: _handleRegister,
            ),
          ],
        ),
      ),
    );
  }
}
