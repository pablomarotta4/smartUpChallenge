import 'package:get/get.dart';
import 'package:smartup_challenge/models/tweet_model.dart';
import 'package:smartup_challenge/repository/tweet_repository.dart';

class TweetController extends GetxController {
  final TweetRepository tweetRepository;
  var tweets = <TweetModel>[].obs;

  TweetController(this.tweetRepository);

  @override
  void onInit() {
    super.onInit();
    loadTweets();
  }

  Future<void> createTweet({required String tweetContent, required String userId, required String username}) async {
    try {
      final tweet = TweetModel(
        username: username,
        tweetContent: tweetContent,
        timestamp: DateTime.now().toString(),
        userId: userId,
      );
      addTweet(tweet);
    } catch (e) {
      print('Error creating tweet: $e');
    }
  }

  Future<void> loadTweets() async {
    try {
      final loadedTweets = await tweetRepository.fetchTweets();
      tweets.assignAll(loadedTweets.toList()); 
    } catch (e) {
      print('Error loading tweets: $e');
    }
  }

  void addTweet(TweetModel tweet) {
    tweetRepository.addTweet(tweet);
  }
}
