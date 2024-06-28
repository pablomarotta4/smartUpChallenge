import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double thickness;

  const CustomDivider({super.key, this.thickness = 0.1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Divider(
        color: Colors.grey.shade400,
        thickness: thickness,
      ),
    );
  }
}
