// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/repository/tweet_repository.dart';

class TweetController extends GetxController {
  final TweetRepository _tweetRepository = TweetRepository();
  var tweets = <TweetModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTweets();
  }

  Future<void> fetchTweets() async {
    try {
      var fetchedTweets = await _tweetRepository.fetchTweets();
      tweets.value = fetchedTweets;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch tweets');
    }
  }

  Future<void> addTweet(TweetModel tweet) async {
    try {
      await _tweetRepository.addTweet(tweet);
      tweets.add(tweet);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add tweet');
    }
  }
}
