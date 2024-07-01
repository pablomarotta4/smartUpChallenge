import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/screens/welcomePage.dart';
import 'package:smartup_challenge/services/post.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      final authController = Provider.of<AuthController>(context, listen: false);
      authController.signOut();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Building MyApp");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        StreamProvider<List<TweetModel>>(
          create: (_) => PostService().getTweets().asyncMap((tweets) async {
            return await compute(parseTweets, tweets);
          }),
          initialData: [],
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color.fromARGB(255, 21, 23, 24),
        ),
        home: const WelcomePage(),
      ),
    );
  }
}

List<TweetModel> parseTweets(List<TweetModel> tweets) {
  return tweets;
}
