import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartup_challenge/models/tweet_model.dart';

class PostService {
  List<TweetModel> _tweetsList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TweetModel(
        tweetContent: (doc.data() as Map<String, dynamic>)['tweetContent'] ?? '',
        creator: (doc.data() as Map<String, dynamic>)['creator'] ?? '',
        timestamp: (doc.data() as Map<String, dynamic>)['timestamp'] ?? 0,
        uid: doc.id,
      );
    }).toList();
  }

  Future<void> postTweet(String text) async {
    if (text.isEmpty) return;

    await FirebaseFirestore.instance.collection('tweets').add({
      'tweetContent': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'creator': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Stream<List<TweetModel>> getTweets() {
    return FirebaseFirestore.instance.collection('tweets').snapshots().map(_tweetsList);
  }
}
