import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_redditech_epitech/models/post_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/subreddit_search_model.dart';

class PostService {
  Future<List<PostsModel>> getPosts(String status) async {
    try {
      String token = (await FlutterSecureStorage().read(key: "token")) ?? "";
      // Equivalent de String? token = await FlutterSecureStorage().read(key: "token")
      String url = "https://oauth.reddit.com/$status";
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent':
            'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)',
        'Authorization': 'Bearer $token',
      });

      if (res.statusCode != 200) {
        throw Exception("Error getting posts");
      }

      Map<String, dynamic> body = jsonDecode(res.body);
      // inspect(body);
      List<PostsModel> posts = [];
      for (Map<String, dynamic> post in body["data"]["children"]) {
        // Aller chercher le type de post et son tex/media
        String type = "text";
        String media = "";
        if (post['data']['media-metadata'] != null &&
            post['data']['is_gallery'] == true) {
          type = "gallery";
          media = post['data']['media-metadata'][0]['s']['u']
              .toString()
              .replaceAll("amp;", "");
        } else if (post['data']['secure_media'] != null &&
            post['data']['secure_media']['type'] == 'youtube') {
          type = 'youtube';
          media = post['data']['url_overridden_by_dest']
              .toString()
              .replaceAll("amp;", "");
        } else if (post['data']['secure_media'] != null &&
            post['data']['secure_media']["reddit_video"] != null) {
          type = 'video';
          media = post['data']['secure_media']["reddit_video"]["fallback_url"]
              .toString()
              .replaceAll("amp;", "");
        } else if (post['data']['preview'] != null) {
          type = "photo";
          media = post['data']['preview']['images'][0]['source']['url']
              .toString()
              .replaceAll("amp;", "");
        } else if (post['data']['selftext'] != null) {
          media = post['data']['selftext'];
        }

        // Aller chercher la date du post (Compare la date actuelle par rapprot au post)
        final timestamp1 = post['data']['created'];
        final DateTime date1 =
            DateTime.fromMillisecondsSinceEpoch(timestamp1.round() * 1000);
        final Duration compare = DateTime.now().difference(date1);
        String date = "${compare.inHours}h";
        if (compare.inHours == 0) {
          date = "${compare.inMinutes}min";
        }

        // Ajouter le PostModel à la liste de posts
        posts.add(PostsModel.fromJson(post, type, media, date));
      }
      return posts;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Error getting posts");
    }
  }

  Future<List<SubredditSearchModel>> getAutocomplete(
      {String query = "a"}) async {
    try {
      String? token =
          (await const FlutterSecureStorage().read(key: "token")) ?? "";
      String url =
          "https://oauth.reddit.com/api/subreddit_autocomplete_v2?query=$query";
      http.Response res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent':
            'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)',
        'Authorization': 'Bearer $token',
      });

      if (res.statusCode != 200) {
        throw Exception("Error getting posts");
      }
      Map<String, dynamic> body = jsonDecode(res.body);
      List<SubredditSearchModel> subreddits = [];
      for (Map<String, dynamic> subreddit in body["data"]["children"]) {
        subreddits.add(SubredditSearchModel.fromJson(subreddit));
      }

      return subreddits;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Error getting autocomplete");
    }
  }
}
