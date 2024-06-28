// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

class VerifyPhonePage extends StatefulWidget {
  final String verificationId;
  final String phone;
  const VerifyPhonePage({super.key, required this.verificationId, required this.phone});


  @override
  _VerifyPhonePageState createState() => _VerifyPhonePageState();
}


  class _VerifyPhonePageState extends State<VerifyPhonePage> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Phone")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: "Verification Code"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}

