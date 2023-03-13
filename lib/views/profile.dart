class Profile extends StatefulWidget {
  const Profile({super.key, required this.username});

  final String username;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Profile? profile;

  getProfile() async {
    final res = await 
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
