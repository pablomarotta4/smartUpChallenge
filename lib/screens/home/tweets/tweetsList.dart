import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartup_challenge/controllers/authController.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:intl/intl.dart';

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
      return const Center(child: Text('No tweets available.'));
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return FutureBuilder<Map<String, String?>>(
          future: _getUserDetails(post.creator),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.hasError) {
              return const Center(child: Text('Error loading user data'));
            }

            final userDetails = snapshot.data ?? {'name': 'Unknown', 'username': 'unknown'};
            final name = userDetails['name'] ?? 'Unknown';
            final username = userDetails['username'] ?? 'unknown';
            final displayTime = _formatTimestamp(post.timestamp);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/user_placeholder.png'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' @$username',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' • $displayTime',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              post.tweetContent,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.comment, size: 20, color: Colors.grey),
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.repeat, size: 20, color: Colors.grey),
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  icon: const Icon(Icons.share, size: 20, color: Colors.grey),
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 1, thickness: 1),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, String?>> _getUserDetails(String uid) async {
    final authController = Provider.of<AuthController>(context, listen: false);
    final name = await authController.getUserName(uid);
    final username = await authController.getUserUsername(uid);
    return {'name': name, 'username': username};
  }

  String _formatTimestamp(String timestamp) {
    final DateTime tweetTime = DateTime.parse(timestamp);
    final Duration difference = DateTime.now().difference(tweetTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return DateFormat('MMM dd').format(tweetTime);
    }
  }
}
