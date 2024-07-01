// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartup_challenge/screens/widgets/divider.dart';

class Tweet extends StatelessWidget {
  final String name;
  final String username;
  final String tweetContent;
  final String timestamp;

  const Tweet({
    super.key,
    required this.name,
    required this.username,
    required this.tweetContent,
    required this.timestamp,
  });

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

  @override
  Widget build(BuildContext context) {
    final displayTime = _formatTimestamp(timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: const NetworkImage('https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/13/1490989105-twitter1.jpg?resize=980:*'),
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
                      tweetContent,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
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
          const CustomDivider(thickness: 0.17),
        ],
      ),
    );
  }
}
