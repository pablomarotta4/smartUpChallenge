import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isAddButton;

  const StoryItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    this.isAddButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isAddButton)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
        Text(name, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
