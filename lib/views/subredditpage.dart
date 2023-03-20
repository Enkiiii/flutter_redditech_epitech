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

  ElevatedButton iconSubAndLabel({IconData? iconSub, String? iconLabel}) {
    return ElevatedButton.icon(
        onPressed: () {
          setState(() {});
        },
        icon: Icon(iconSub),
        label: Text(iconLabel!));
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
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/BackgroundRedditech.png'),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.network(
                          subreddit!.bannerBackgroundImage,
                          fit: BoxFit.cover,
                          height: 65,
                        ),
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
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(0, 221, 217, 217)
                                  .withOpacity(0.9),
                            ),
                            child: Expanded(
                              child: Text(
                                subreddit!.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("By "),
                          Text(subreddit!.name),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: iconSubAndLabel(
                                iconLabel: (subreddit!.subscribed == true)
                                    ? "Subbed"
                                    : "Not Subbed",
                                iconSub: (subreddit!.subscribed == true)
                                    ? Icons.favorite
                                    : Icons.favorite_border),
                          ),
                          ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //     onSurface: Color.fromARGB(255, 95, 69, 30)),
                            onPressed: () {},
                            child: Text(subreddit!.subscribers.toString()),
                          ),
                        ],
                      ),
                    ),
                    Text(subreddit!.description),
                  ],
                ),
              ),
            ),
    );
  }
}
