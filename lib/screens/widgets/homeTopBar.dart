// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _onMenuButtonPressed(BuildContext context) {
  }

  void _onStarButtonPressed(BuildContext context) {
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.blue),
        onPressed: () => _onMenuButtonPressed(context),
      ),
      title: Center(
        child: Image.asset(
          'assets/icons/twitter.png', 
          height: 30,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.star, color: Colors.blue),
          onPressed: () => _onStarButtonPressed(context),
        ),
      ],
    );
  }
}
