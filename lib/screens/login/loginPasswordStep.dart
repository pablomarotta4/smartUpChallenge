import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/screens/home/home.dart';

class EnterPasswordPage extends StatefulWidget {
  final String loginFactor;
  const EnterPasswordPage({Key? key, required this.loginFactor}) : super(key: key);

  @override
  _EnterPasswordPageState createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorText;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _handleLogin() async {
    String password = _passwordController.text;
    try {
      UserCredential userCredential;
      if (widget.loginFactor.contains('@')) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: widget.loginFactor,
          password: password,
        );
        setState(() {
          _errorText = null;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        });
      } else if (RegExp(r'^\+?[0-9]{10,15}$').hasMatch(widget.loginFactor)) {
        // logica del auth de numero de telefono
        print("Autenticación con teléfono no implementada en este ejemplo");
        return;
      } else {
        // auth con nombre de usuario
        print("Autenticación con nombre de usuario no implementada en este ejemplo");
        return;
      }
      print("Inicio de sesión exitoso: ${userCredential.user?.uid}");
    } catch (e) {
      print('Error al iniciar sesión: $e');
      setState(() {
        _errorText = 'Error al iniciar sesión';
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
             Expanded(
              child: Container(),
            ),
            LoginFooter(
              buttonType: 'login',
              onPressed:  _handleLogin,
            ),
          ],
        ),
      ),
    );
  }
}
