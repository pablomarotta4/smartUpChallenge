import 'package:flutter/material.dart';

class WelcomePageFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Asegura que los elementos en la columna estén alineados a la izquierda
        children: [
          RichText(
            textAlign: TextAlign.left, // Alinea el texto a la izquierda
            text: const TextSpan(
              text: 'Have an account already? ',
              style: TextStyle(color: Colors.grey, fontSize: 10),
              children: <TextSpan>[
                TextSpan(
                  text: 'Log In',
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                  // Acción de navegación a la pantalla de inicio de sesión
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
