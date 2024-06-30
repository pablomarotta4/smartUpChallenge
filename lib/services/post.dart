import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:smartup_challenge/models/tweet_model.dart';

class PostService {
  List<TweetModel> _tweetsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return TweetModel(
        tweetContent: data['tweetContent'] ?? '',
        timestamp: data['timestamp'] ?? '',
        creator: data['creator'] ?? '',
        uid: doc.id,
      );
    }).toList();
  }

  Future<void> postTweet(String text) async {
    if (text.isEmpty) return;

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    await FirebaseFirestore.instance.collection('tweets').add({
      'tweetContent': text,
      'timestamp': formattedDate,
      'creator': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Stream<List<TweetModel>> getTweets() {
    return FirebaseFirestore.instance
        .collection('tweets')
        .orderBy('timestamp', descending: true) 
        .snapshots()
        .map(_tweetsList);
  }
}
