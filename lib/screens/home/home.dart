import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/homeTopBar.dart';
import 'package:smartup_challenge/screens/widgets/homeBottomBar.dart';
import 'package:smartup_challenge/screens/home/storys/storyList.dart';
import 'package:smartup_challenge/screens/home/tweets/tweetsList.dart'; // Asegúrate de importar el archivo correcto

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeTopBar(),
      body: Column(
        children: [
          StoryList(),
          const CustomDivider(thickness: 0.5),
          const Expanded(child: TweetsList()), 
        ],
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
