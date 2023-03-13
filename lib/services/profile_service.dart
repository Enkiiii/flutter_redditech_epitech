import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_redditech_epitech/models/profiles_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<ProfilesModel?> getProfile() async {
    try {
    final String? token = await FlutterSecureStorage().read(key: "token");
    String url = 'https://oauth.reddit.com/api/v1/me';
    http.Response res = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent':
            'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode != 200) {
        throw Exception("Error getting profile");
      }

    Map<String, dynamic> body = jsonDecode(res.body);
    final ProfilesModel profile = ProfilesModel.fromJson(body);
    return profile;

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception("Error getting profile");
    }
  }
}
