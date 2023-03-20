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
                Row(
                  children: [
                    SizedBox(
                        child: Image.network(
                      subreddit!.communityIcon,
                      height: 50,
                      width: 50,
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(subreddit!.title),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: Row(
                        children: [
                          const Text("by "),
                          Text(subreddit!.name),
                        ],
                      ),
                    ),
                  ],
                ),
                // TODO : Superposer la le titre et l'icone à la banner
                Image.network(subreddit!.bannerBackgroundImage),
                Text(subreddit!.description),
                Text(subreddit!.subscribed.toString()),
                Text(subreddit!.subscribers.toString()),
              ],
            ),
    );
  }
}
