import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/tweetController.dart';
import 'package:get/get.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/screens/home/drawer/drawerTopBar.dart';
import 'package:smartup_challenge/controllers/authController.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TweetController tweetController = Get.find<TweetController>();
    final auth = Provider.of<AuthController>(context, listen: false);
    final TextEditingController tweetControllerText = TextEditingController();

    Future<void> postTweet() async {
      final tweetContent = tweetControllerText.text.trim();
      if (tweetContent.isNotEmpty) {
        final user = auth.user;
        if (user != null) {
          final activeUser = auth.activeUser;
          if (activeUser != null) {
            await tweetController.createTweet(
              tweetContent: tweetContent,
              userId: user.uid,
              username: activeUser.username,
            );
            tweetControllerText.clear();
            Navigator.pop(context);
          } else {
            print('Active user not found');
          }
        } else {
          print('No user logged in');
        }
      }
    }

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerTopBar(onPost: postTweet),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: tweetControllerText,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: "What's happening?",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
