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
          : Column(
              children: [
                Text(profile!.username),
                Image.network(profile!.picture),
                Text(profile!.description),
              ],
            ),
    );
  }
}
