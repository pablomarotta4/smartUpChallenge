import 'package:flutter/material.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/home/drawer/drawer.dart';
import 'package:smartup_challenge/screens/home/tweets/tweets.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';
import 'package:smartup_challenge/screens/widgets/homeTopBar.dart';
import 'package:smartup_challenge/screens/widgets/homeBottomBar.dart';
import 'package:smartup_challenge/screens/home/storys/storyList.dart';
import 'package:smartup_challenge/screens/widgets/flyingDrawerButton.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeTopBar(),
      body: Stack(
        children: [
          Column(
            children: [
              StoryList(),
              const CustomDivider(thickness: 0.3),
              const Expanded(child: Tweets()),
            ],
          ),
          Positioned(
            bottom: 80,
            right: 20,
            child: FlyingDrawerButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DrawerWidget(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
