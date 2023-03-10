import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ProfileService?> getProfile() async {
    final String? token = await FlutterSecureStorage().read(key: "token");
    String url = 'https://oauth.reddit.com/api/v1/me';
    http.Response res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent':
          'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)',
      'Authorization': 'Bearer $token',
    });
    Map result = jsonDecode(res.body);
    inspect(result);
    inspect(result['subreddit']['title']);
  }
}
