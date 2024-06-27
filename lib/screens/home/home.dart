import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/widgets/homeTopBar.dart';
import 'package:smartup_challenge/screens/widgets/homeBottomBar.dart';
import 'package:smartup_challenge/screens/home/storys/storyList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeTopBar(),
      body: Column(
        children: [
          StoryList(),
        ],
      ),
      bottomNavigationBar: HomeBottomBar(),    );
  }
}
