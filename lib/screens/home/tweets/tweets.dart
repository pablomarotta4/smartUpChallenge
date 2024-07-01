// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/services/post.dart';
import 'package:smartup_challenge/screens/home/tweets/tweetsList.dart';

class Tweets extends StatefulWidget {
  const Tweets({super.key});

  @override
  _TweetsState createState() => _TweetsState();
}

class _TweetsState extends State<Tweets> {
  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TweetModel>>.value(
      value: _postService.getTweets(),
      initialData: const [],
      child: const TweetsList(),
    );
  }
}
