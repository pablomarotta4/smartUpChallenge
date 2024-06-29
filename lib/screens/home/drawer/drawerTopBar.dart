import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/screens/widgets/smallButton.dart';

class DrawerTopBar extends StatelessWidget {
  final VoidCallback onPost;

  const DrawerTopBar({required this.onPost, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          SmallButton(
            buttonType: 'post',
            onPressed: onPost,
          ),
        ],
      ),
    );
  }
}
