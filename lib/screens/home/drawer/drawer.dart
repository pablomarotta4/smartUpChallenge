import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/screens/home/drawer/drawerTopBar.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/services/post.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context, listen: false);
    final TextEditingController tweetControllerText = TextEditingController();
    PostService postService = PostService();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerTopBar(
            onPost: () async {
              await postService.postTweet(tweetControllerText.text);
              Navigator.of(context).pop(); // Cierra el drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
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
