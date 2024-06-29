import 'package:flutter/material.dart';

class FlyingDrawerButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FlyingDrawerButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}