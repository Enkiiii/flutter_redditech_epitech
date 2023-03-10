// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter_redditech_epitech/models/favourites_model.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;

// class FavouriteService {
//   Future<FavouriteService?> getFavourite() async {
//     final String? token = await FlutterSecureStorage().read(key: "token");
//     // Trouver le bon lien 
//     String url = 'https://oauth.reddit.com/';
//     http.Response res = await http.get(Uri.parse(url), headers: {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//       'User-Agent':
//           'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)',
//       'Authorization': 'Bearer $token',
//     });
//     Map result = jsonDecode(res.body);
//     inspect(result);
//   }
// }
