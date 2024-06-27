import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:provider/provider.dart';

class EnterPasswordPage extends StatefulWidget {
  final String loginFactor;
  const EnterPasswordPage({Key? key, required this.loginFactor}) : super(key: key);

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

  void _handleLogin() async {
    String password = _passwordController.text;
    final auth = Provider.of<AuthController>(context, listen: false);

    try {
      UserCredential? loginSuccess;
      if (widget.loginFactor.contains('@')) {
        String email = widget.loginFactor;
        loginSuccess = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (widget.loginFactor.contains('+')) {
        String phone = widget.loginFactor;
        await auth.phoneAuthentication(phone);
      }
      else{
        //Implement
      }

      if (mounted && loginSuccess != null && loginSuccess.user != null) {
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
          _errorText = 'Error al iniciar sesión';
        });
      }
    } catch (e) {
      setState(() {
        _errorText = 'Error al iniciar sesión';
      });
      print('Error al iniciar sesión: $e');
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
          children: [
            HeaderWidget(showButton: true, iconType: 'back'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter your password",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
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
              buttonType: 'login',
              onPressed: _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
