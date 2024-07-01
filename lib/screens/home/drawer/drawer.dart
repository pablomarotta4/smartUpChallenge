// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/screens/home/drawer/drawerTopBar.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/screens/home/home.dart';
import 'package:smartup_challenge/services/post.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final TextEditingController _tweetController = TextEditingController();
  final PostService _postService = PostService();

  @override
  void dispose() {
    _tweetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthController>(context, listen: false);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerTopBar(
            onPost: () async {
              await _postService.postTweet(_tweetController.text);
              if (context.mounted) {
                _navigateToHome(context);
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _tweetController,
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

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pop(); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }
}
