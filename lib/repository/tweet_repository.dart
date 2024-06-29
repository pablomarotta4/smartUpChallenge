import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartup_challenge/models/tweet_model.dart';

class TweetRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTweet(TweetModel tweet) async {
    try {
      await _firestore.collection('tweets').add(tweet.toMap());
    } catch (e) {
      throw Exception('Error adding tweet: $e');
    }
  }

  Future<List<TweetModel>> fetchTweets() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('tweets').orderBy('timestamp', descending: true).get();
      return snapshot.docs.map((doc) => TweetModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception('Error fetching tweets: $e');
    }
  }
}
