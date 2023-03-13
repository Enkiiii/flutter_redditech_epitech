import 'package:flutter/material.dart';
import 'package:flutter_redditech_epitech/services/auth_service.dart';
import 'package:flutter_redditech_epitech/views/home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    size.width;
    size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await AuthService().login();
            // Une fois qu'on a le token,
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: SizedBox(
            width: size.width * 0.7,
            child: const Text("login"),
          ),
        ),
      ),
    );
  }
}
