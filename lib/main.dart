import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/welcomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        theme: ThemeData(
        brightness: Brightness.dark, 
        scaffoldBackgroundColor: Color.fromARGB(255, 21, 23, 24), 
      ),
        home: WelcomePage(),
      ),
    );
  }
}
