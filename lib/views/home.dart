// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redditech_epitech/models/post_model.dart';
import 'package:flutter_redditech_epitech/services/post_service.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter_redditech_epitech/utils/subreddit_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                tooltip: 'Search',
                onPressed: () async {
                  final res = await PostService().getAutocomplete();
                  final result = await showSearch(
                      context: context,
                      delegate: SubredditSearch(subreddits: res));
                  // storage.setItem('subreddit', result.toString());
                  // Navigator.pushNed(context, '/subreddit');
                },
              ),
            ),
          ]),
      body: FutureBuilder<List<PostsModel>>(
        future: PostService().getPosts("hot"),
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
          // Equivalent d'un if "??"
          List<PostsModel> posts = snapshot.data ?? [];
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].author),
              );
            },
          );
        },
      ),
    );
  }
}






//  return Row(
//                 children: [
//                   SafeArea(
//                     child: NavigationRail(
//                       extended: false,
//                       destinations: [
//                         NavigationRailDestination(
//                           icon: Icon(Icons.home),
//                           label: Text('Home'),
//                         ),
//                         NavigationRailDestination(
//                           icon: Icon(Icons.account_circle_rounded),
//                           label: Text('Profile'),
//                         ),
//                       ],
//                       selectedIndex: 0,
//                       onDestinationSelected: (value) {
//                         print('selected: $value');
//                       },
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                       ProfileService().getProfile();
//                     },
//                     child: Text('Profile'),
//                   ),
//                 ],
//               );