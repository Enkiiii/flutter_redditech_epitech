import 'package:flutter/material.dart';
import '../models/subreddits_model.dart';
import '../services/post_service.dart';

class SubRedditPage extends StatefulWidget {
  const SubRedditPage({super.key, required this.title});

  final String title;

  @override
  State<SubRedditPage> createState() => _SubRedditPageState();
}

class _SubRedditPageState extends State<SubRedditPage> {
  SubredditModel? subreddit;

  getSubreddit() async {
    final res = await PostService().getSubReddit(widget.title);
    setState(() {
      subreddit = res;
    });
  }

  @override
  void initState() {
    getSubreddit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: subreddit == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
            children: [
              Text(subreddit!.name),
              Text(subreddit!.description),
              Text(subreddit!.title),
              Text(subreddit!.subscribed.toString()),
              Text(subreddit!.subscribers.toString()),
              Image.network(subreddit!.bannerBackgroundImage),
              Image.network(subreddit!.communityIcon),
            ],
          )
    );
  }
}