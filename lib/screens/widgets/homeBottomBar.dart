// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  void _onHomeButtonPressed() {
    // acción del botón Home
  }

  void _onSearchButtonPressed() {
    // acción del botón Search
  }

  void _onNotificationsButtonPressed() {
    // acción del botón Notifications
  }

  void _onMailButtonPressed() {
    // acción del botón Mail
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 55.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.blue, size: 28),
                  onPressed: _onHomeButtonPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.grey, size: 28),
                  onPressed: _onSearchButtonPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: Colors.grey, size: 28),
                  onPressed: _onNotificationsButtonPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(Icons.mail_outline, color: Colors.grey, size: 28),
                  onPressed: _onMailButtonPressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
