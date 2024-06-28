import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/welcomePage.dart'; // Asegúrate de importar la página principal

class HeaderWidget extends StatefulWidget {
  final bool showButton;
  final String iconType; 
  final Map<String, IconData> iconSelector = {
    'close': Icons.close,
    'back': Icons.arrow_back,
  };

  HeaderWidget({Key? key, this.showButton = true, this.iconType = 'back'}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.showButton
              ? GestureDetector(
                  onTap: () {
                    if (widget.iconType == 'close') {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomePage()),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(widget.iconSelector[widget.iconType], color: Colors.blue),
                )
              : Container(),
          Image.asset('assets/icons/twitter.png', height: 35, width: 35),
          const SizedBox(width: 24), 
        ],
      ),
    );
  }
}
