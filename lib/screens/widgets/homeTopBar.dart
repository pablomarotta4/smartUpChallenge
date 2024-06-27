import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.blue),
        onPressed: () {
          // accion del botón
        },
      ),
      title: Center(
        child: Image.asset(
          'assets/icons/twitter.png', 
          height: 30,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.star, color: Colors.blue),
          onPressed: () {
            // acción del boton
          },
        ),
      ],
    );
  }
}
