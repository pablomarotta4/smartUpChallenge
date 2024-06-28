class TweetModel {
  final String tweetContent;
  final String timestamp;
  final String userId;
  final String username;

  TweetModel({
    required this.tweetContent,
    required this.timestamp,
    required this.userId,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'tweetContent': tweetContent,
      'timestamp': timestamp,
      'userId': userId,
      'username': username,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweetContent: map['content'] as String,
      timestamp: map['timestamp'] as String,
      userId: map['userId'] as String,
      username: map['username'] as String,
    );
  }
}
