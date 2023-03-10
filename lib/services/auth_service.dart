import 'package:draw/draw.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

class AuthService {
     login() async {
    final reddit = Reddit.createInstalledFlowInstance(
        clientId: 'OvH70YVeaq_UcQAwt2LmRw', // CLIENT_ID
        userAgent:
            'flutter_project_enki:1234:1.0 (by /u/Global-Philosophy-68)', // u/USERNAME
        redirectUri: Uri.parse('foobar://success'));
    final authUrl = reddit.auth.url(['*'], 'foobar');
    final res = await FlutterWebAuth.authenticate(
        url: authUrl.toString(), callbackUrlScheme: 'foobar');
    // foobar://success?code=CODE&state=STATE
    final Uri resUri = Uri.parse(res);
    final String? code = resUri.queryParameters[
        'code']; // String?  "?" Prévient que cela peut etre nul
    if (code != null) {
      await reddit.auth.authorize(code);
      print(reddit.auth.credentials.accessToken);
      await FlutterSecureStorage()
          .write(key: "token", value: reddit.auth.credentials.accessToken);
    }
  }
}