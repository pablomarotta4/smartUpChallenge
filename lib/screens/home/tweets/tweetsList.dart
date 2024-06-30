import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/models/tweet_model.dart';

class Tweetslist extends StatefulWidget {
  const Tweetslist({super.key});

  @override
  _TweetslistState createState() => _TweetslistState();
}

class _TweetslistState extends State<Tweetslist> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<TweetModel>>(context) ?? [];
    if (posts.isEmpty) { 
      return Center(child: Text('No tweets available.'));
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.creator),
          subtitle: Text(post.tweetContent),
          trailing: Text(post.timestamp), 
        );
      },
    );
  }
}
