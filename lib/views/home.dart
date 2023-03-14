// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_redditech_epitech/models/post_model.dart';
import 'package:flutter_redditech_epitech/services/post_service.dart';
import 'package:flutter_redditech_epitech/utils/subreddit_search.dart';
import 'package:flutter_redditech_epitech/views/subredditpage.dart';

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
                  final String? result = await showSearch<String>(
                      context: context,
                      delegate: SubredditSearch(subreddits: res));
                  if (result != null && result.isNotEmpty && result != 'Done') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubRedditPage(title: result),
                      ),
                    );
                  }
                  // storage.setItem('subreddit', result.toString());
                  // Navigator.pushNed(context, '/subreddit');
                },
              ),
            ),
          ]),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.local_fire_department),
                label: Text("Hot"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 57, 53, 49),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.new_releases),
                  label: Text("New"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 57, 53, 49),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                  label: Text("Sub"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 57, 53, 49),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.account_circle),
                label: Text("Profile"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 57, 53, 49),
                    foregroundColor: Color.fromARGB(255, 255, 153, 0)),
              ),
            ],
          ),
          FutureBuilder<List<PostsModel>>(
            future: PostService().getPosts("new"),
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
              return Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].author),
                    );
                  },
                ),
              );
            },
          ),
        ],
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