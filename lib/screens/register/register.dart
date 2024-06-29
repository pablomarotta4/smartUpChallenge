// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/authenticate/verifyPhonePage.dart';
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
    String name = _nameController.text.trim();
    String emailOrPhone = _emailOrPhoneController.text.trim();
    String birth = _birthController.text.trim();
    final auth = Provider.of<AuthController>(context, listen: false);

    if (name.isEmpty || emailOrPhone.isEmpty || birth.isEmpty) {
      setState(() {
        _errorText = 'All fields are required';
      });
    } else if (emailOrPhone.contains('@')) {
      if (await auth.checkIfEmailExists(emailOrPhone)) {
        setState(() {
          _errorText = 'Email already exists';
        });
      } else {
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
    } else if (emailOrPhone.contains('+')) {
      if (await auth.checkIfPhoneExists(emailOrPhone)) {
        setState(() {
          _errorText = 'Phone number already exists';
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyPhonePage(
              phone: emailOrPhone,
              verificationId: '',
            ),
          ),
        );
      }
    } else {
      setState(() {
        _errorText = 'Invalid phone number or email address';
      });
    }
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(showButton: true, iconType: 'back'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                "Create your account",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailOrPhoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone number or email address',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _birthController,
                    decoration: const InputDecoration(
                      hintText: 'Date of birth',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
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
            Expanded(child: Container()),
            CustomDivider(),
            RegisterFooter(
              onPressed: _nextStep,
              buttonType: "next",
            ),
          ],
        ),
      ),
    );
  }
}
