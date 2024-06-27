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
      UserCredential loginSuccess;
      if (widget.loginFactor.contains('@')) {
        loginSuccess = await auth.signInWithEmailAndPassword(
          email: widget.loginFactor,
          password: password,
        );
      } else if (RegExp(r'^\+?[0-9]{10,15}$').hasMatch(widget.loginFactor)) {
        // implementar logica de authenticacion con tel
        print("Autenticación con teléfono no implementada en este ejemplo");
        return;
      } else {
        // implementar logica de inicio de sesion con username
        print("Autenticación con nombre de usuario no implementada en este ejemplo");
        return;
      }

      if (mounted) {
        setState(() {
          _errorText = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorText = 'Error al iniciar sesión';
        });
      }
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
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "Enter your password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
