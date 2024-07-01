// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/register/registerPasswordStep.dart';
import 'package:smartup_challenge/screens/widgets/registerFooter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  String? _errorText;

  Future<void> _nextStep() async {
    final String name = _nameController.text.trim();
    final String emailOrPhone = _emailOrPhoneController.text.trim();
    final String birth = _birthController.text.trim();
    final auth = Provider.of<AuthController>(context, listen: false);

    if (_validateInput(name, emailOrPhone, birth)) {
      try {
        if (emailOrPhone.contains('@')) {
          await _handleEmailValidation(auth, name, emailOrPhone, birth);
        } else if (emailOrPhone.contains('+')) {
          await _handlePhoneValidation(auth, name, emailOrPhone, birth);
        } else {
          _setErrorText('Invalid phone number or email address');
        }
      } catch (e) {
        _setErrorText('An error occurred. Please try again.');
      }
    }
  }

  bool _validateInput(String name, String emailOrPhone, String birth) {
    if (name.isEmpty || emailOrPhone.isEmpty || birth.isEmpty) {
      _setErrorText('All fields are required');
      return false;
    }
    return true;
  }

  Future<void> _handleEmailValidation(AuthController auth, String name, String emailOrPhone, String birth) async {
    if (await auth.checkIfEmailExists(emailOrPhone)) {
      _setErrorText('Email already exists');
    } else {
      _navigateToRegisterPasswordStep(name, emailOrPhone, birth);
    }
  }

  Future<void> _handlePhoneValidation(AuthController auth, String name, String emailOrPhone, String birth) async {
    if (await auth.checkIfPhoneExists(emailOrPhone)) {
      _setErrorText('Phone number already exists');
    } else {
      // Lógica de autenticación con teléfono (OTP)
    }
  }

  void _navigateToRegisterPasswordStep(String name, String emailOrPhone, String birth) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPasswordStep(
          name: name,
          emailOrPhone: emailOrPhone,
          birth: birth,
        ),
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
    _nameController.dispose();
    _emailOrPhoneController.dispose();
    _birthController.dispose();
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
            const HeaderWidget(showButton: true, iconType: 'back'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: Text(
                "Create your account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          maxLength: 50,
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _emailOrPhoneController,
                          decoration: const InputDecoration(
                            hintText: 'Phone number or email address',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _birthController,
                          decoration: const InputDecoration(
                            hintText: 'Date of birth',
                            hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        if (_errorText != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              _errorText!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const CustomDivider(thickness: 0.01),
            RegisterFooter(onPressed: _nextStep, buttonType: 'next'),
          ],
        ),
      ),
    );
  }
}
