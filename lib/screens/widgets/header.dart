// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/welcomePage.dart'; 

class HeaderWidget extends StatefulWidget {
  final bool showButton;
  final String iconType;
  final Map<String, IconData> iconSelector = const {
    'close': Icons.close,
    'back': Icons.arrow_back,
  };

  const HeaderWidget({
    super.key,
    this.showButton = true,
    this.iconType = 'back',
  });

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  void _handleIconTap() {
    if (widget.iconType == 'close') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const WelcomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.showButton)
            GestureDetector(
              onTap: _handleIconTap,
              child: Icon(widget.iconSelector[widget.iconType], color: Colors.blue),
            ),
          Image.asset('assets/icons/twitter.png', height: 35, width: 35),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
