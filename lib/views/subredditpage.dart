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

  getIconSub() {
    IconData iconSub;
    String iconLabel;
    if (subreddit!.subscribed == true) {
      iconSub = Icons.favorite;
      iconLabel = "Subbed";
    } else {
      iconSub = Icons.favorite_border;
      iconLabel = "Not Subbed";
    }
    return iconSub;
  }

  getIconLabel() {
    String iconLabel;
    if (subreddit!.subscribed == true) {
      iconLabel = "Subbed";
    } else {
      iconLabel = "Not Subbed";
    }
    return iconLabel;
  }

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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      // TODO : Superposer le titre et l'icone à la banner
                      Image.network(subreddit!.bannerBackgroundImage),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Image.network(
                          subreddit!.communityIcon,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                        child: Text(subreddit!.title),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: Row(
                          children: [
                            const Text("By "),
                            Text(subreddit!.name),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO : Ajouter fonction pouvoir se sub ou desub
                              },
                              icon: Icon(getIconSub()),
                              label: Text(getIconLabel())),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onSurface: Color.fromARGB(255, 95, 69, 30)),
                          onPressed: null,
                          child: Text(subreddit!.subscribers.toString()),
                        ),
                      ],
                    ),
                  ),
                  Text(subreddit!.description),
                ],
              ),
            ),
    );
  }
}
