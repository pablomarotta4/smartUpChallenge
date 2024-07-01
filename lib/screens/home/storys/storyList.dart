// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:smartup_challenge/screens/home/storys/story.dart';

class StoryList extends StatelessWidget {
  final List<StoryData> stories = [
    StoryData(name: 'Add', imageUrl: 'https://hips.hearstapps.com/digitalspyuk.cdnds.net/17/13/1490989105-twitter1.jpg?resize=980:*', isAddButton: true),
    StoryData(name: 'María', imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Mar%C3%ADa_Becerra_2023_03.jpg'),
    StoryData(name: 'Taylor', imageUrl: 'https://people.com/thmb/logWYJ7TOemKo4lujE-M4kKNQvM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(749x164:751x166)/Taylor-Swift-life-101123-tout-b99b188465254ec0a8eb50fa653b51dc.jpg'),
    StoryData(name: 'Lio', imageUrl: 'https://hips.hearstapps.com/hmg-prod/images/lionel-messi-celebrates-after-their-sides-third-goal-by-news-photo-1686170172.jpg?crop=0.66653xw:1xh;center,top&resize=640:*'),
    StoryData(name: 'Elon', imageUrl: 'https://images.wsj.net/im-849543/?width=1278&size=1'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 101,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryItem(
            name: story.name,
            imageUrl: story.imageUrl,
            isAddButton: story.isAddButton,
          );
        },
      ),
    );
  }
}

class StoryData {
  final String name;
  final String imageUrl;
  final bool isAddButton;

  StoryData({required this.name, required this.imageUrl, this.isAddButton = false});
}
