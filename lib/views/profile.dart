import 'package:flutter/material.dart';
import 'package:flutter_redditech_epitech/services/profile_service.dart';

import '../models/profiles_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfilesModel? profile;

  getProfile() async {
    final res = await ProfileService().getProfile();
    setState(() {
      profile = res;
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: profile == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: SizedBox(
                          child: Image.network(profile!.picture),
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(profile!.username),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(profile!.description),
                      ],
                    ),
                  ),

                  // TODO : Ajouter les settings dans la page profil
                ],
              ),
            ),
    );
  }
}
