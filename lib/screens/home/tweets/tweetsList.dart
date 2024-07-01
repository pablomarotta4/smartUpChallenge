// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/screens/home/tweets/singleTweet.dart';

class TweetsList extends StatefulWidget {
  const TweetsList({super.key});

  @override
  _TweetsListState createState() => _TweetsListState();
}

class _TweetsListState extends State<TweetsList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<TweetModel>>(context);
    if (posts.isEmpty) {
      return const Center(child: Text('No tweets available.'));
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return FutureBuilder<Map<String, String?>>(
          future: _getUserDetails(context, post.creator),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            }

            final userDetails = snapshot.data ?? {'name': 'Unknown', 'username': 'unknown'};
            final name = userDetails['name'] ?? 'Unknown';
            final username = userDetails['username'] ?? 'unknown';

            return Tweet(
              name: name,
              username: username,
              tweetContent: post.tweetContent,
              timestamp: post.timestamp,
            );
          },
        );
      },
    );
  }

  Future<Map<String, String?>> _getUserDetails(BuildContext context, String uid) async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final name = await authController.getUserName(uid);
    final username = await authController.getUserUsername(uid);
    return {'name': name, 'username': username};
  }
}
