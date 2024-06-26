import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartup_challenge/screens/authRedirect.dart';
import 'package:smartup_challenge/screens/welcomePage.dart';
import '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Color.fromARGB(255, 21, 23, 24), 
      ),
      home: WelcomePage(),
    );
  }
}
