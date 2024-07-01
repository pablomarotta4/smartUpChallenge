import 'package:cloud_firestore/cloud_firestore.dart';

class TweetModel {
  final String tweetContent;
  final String timestamp; 
  final String creator;
  final String uid;

  TweetModel({
    required this.tweetContent,
    required this.timestamp,
    required this.creator,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweetContent': tweetContent,
      'timestamp': timestamp,
      'creator': creator,
      'uid': uid,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweetContent: map['tweetContent'] as String? ?? '',
      timestamp: map['timestamp'] as String? ?? '',
      creator: map['creator'] as String? ?? '',
      uid: map['uid'] as String? ?? '',
    );
  }

  factory TweetModel.fromDocumentSnapshot(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TweetModel(
      tweetContent: data['tweetContent'] as String? ?? '',
      timestamp: data['timestamp'] as String? ?? '',
      creator: data['creator'] as String? ?? '',
      uid: doc.id,
    );
  }
}
