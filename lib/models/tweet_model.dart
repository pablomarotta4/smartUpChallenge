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
      'userId': creator,
      'username': uid,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweetContent: map['content'] as String,
      timestamp: map['timestamp'] as String,
      creator: map['creator'] as String,
      uid: map['uid'] as String,
    );
  }
}
