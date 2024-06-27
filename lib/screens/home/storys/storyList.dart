import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/home/storys/story.dart';


class StoryList extends StatelessWidget {
  final List<Map<String, String>> stories = [
    {'name': 'Add', 'imageUrl': 'https://example.com/add.jpg', 'isAddButton': 'true'},
    {'name': 'Jess', 'imageUrl': 'https://example.com/jess.jpg'},
    {'name': 'Vera', 'imageUrl': 'https://example.com/vera.jpg'},
    {'name': 'Kian', 'imageUrl': 'https://example.com/kian.jpg'},
    {'name': 'Suzie', 'imageUrl': 'https://example.com/suzie.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryItem(
            name: story['name']!,
            imageUrl: story['imageUrl']!,
            isAddButton: story['isAddButton'] == 'true',
          );
        },
      ),
    );
  }
}
