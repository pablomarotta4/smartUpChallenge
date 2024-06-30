import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/header.dart';
import 'package:smartup_challenge/screens/register/registerPasswordStep.dart';
import 'package:smartup_challenge/screens/widgets/loginFooter.dart';
import 'package:smartup_challenge/screens/widgets/registerFooter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
        // await auth.phoneAuthentication(emailOrPhone);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => OtpVerificationPage(),
        //   ),
        // );
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
      backgroundColor: const Color.fromARGB(255, 21, 23, 24),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(showButton: true, iconType: 'back'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: Text(
                "Create your account",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
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
