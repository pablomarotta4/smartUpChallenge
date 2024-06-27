import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup_challenge/controllers/otpController.dart';

class OtpVerificationPage extends StatelessWidget {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String otp = _otpController.text.trim();
                OtpController.to.verifyOtp(otp);
              },
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
