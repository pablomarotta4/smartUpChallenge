import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartup_challenge/controllers/tweetController.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';

class TweetsList extends StatelessWidget {
  const TweetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final TweetController tweetController = Get.put(TweetController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        const CustomDivider();
        if (tweetController.tweets.isEmpty) {
          return const Center(
            child: Text('No tweets yet.'),
          );
        } else {
          return ListView.builder(
            itemCount: tweetController.tweets.length,
            itemBuilder: (context, index) {
              final tweet = tweetController.tweets[index];
              return ListTile(
                title: Text(tweet.username),
                subtitle: Text(tweet.tweetContent),
                trailing: Text(tweet.timestamp),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // logica para agregar un nuevo tweet
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
