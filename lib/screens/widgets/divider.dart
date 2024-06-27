import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Divider(
        color: Colors.grey.shade400, 
        thickness: 0.5,
      ),
    );
  }
}
