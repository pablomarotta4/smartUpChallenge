import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isAddButton;

  const StoryItem({
    super.key,
    required this.name,
    required this.imageUrl,
    this.isAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              width: 65,
              height: 65,
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
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 16),
                ),
              ),
          ],
        ),
        Text(name, style: const TextStyle(color: Color.fromARGB(255, 163, 163, 163))),
      ],
    );
  }
}
