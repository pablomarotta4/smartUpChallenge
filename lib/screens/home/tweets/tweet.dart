import 'package:flutter/material.dart';
import 'package:smartup_challenge/models/tweet_model.dart';

class TweetCard extends StatelessWidget {
  final TweetModel tweet;

  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage("assets/images/defaultUserImage.png")
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tweet.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(tweet.tweetContent),
                  const SizedBox(height: 5),
                  Text(
                    tweet.timestamp,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
}
