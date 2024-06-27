import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6.0,
      color: Colors.white,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset('assets/icons/birdhouse.png', height: 30, width: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
