import 'package:flutter/material.dart';
import 'package:flutter_redditech_epitech/models/subreddit_search_model.dart';
import 'package:flutter_redditech_epitech/services/post_service.dart';

class SubredditSearch extends SearchDelegate<String> {
  SubredditSearch({Key? key, required this.subreddits});

  final List<SubredditSearchModel> subreddits;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, "Done");
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "Done");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<SubredditSearchModel>>(
        future: PostService().getAutocomplete(query: query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const Center(
              child: Text('Error'),
            );
          }
          return buildSuggestionsSuccess(snapshot.data!);
        });
  }

  buildSuggestionsSuccess(List<SubredditSearchModel> subreddits) =>
      ListView.builder(
        itemCount: subreddits.length,
        itemBuilder: (context, index) {
          final suggestion = subreddits[index];
          var queryText = "";
          var remainingText = "";
          if (suggestion.title != null) {
            // On ajoute un "+2" par rapport à reddit "r/ u/ etc"
            queryText = suggestion.title.substring(0, query.length + 2);
            remainingText = suggestion.title.substring(query.length + 2);
          } else {
            queryText = "";
            remainingText = "";
          }
          final img = suggestion.img;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(img),
                backgroundColor: Colors.grey,
              ),
              title: RichText(
                text: TextSpan(
                  text: queryText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: remainingText,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                query = suggestion.title;
                close(context, suggestion.title);
              },
            ),
          );
        },
      );
}
