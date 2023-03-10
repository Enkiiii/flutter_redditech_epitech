class   ProfilesModel {
  final String username;
  final String description;
  final String picture;

  ProfilesModel(
      {this.username = "",
      this.description = "",
      this.picture = "",});

  factory ProfilesModel.fromJson(Map<String, dynamic> json) {
    return ProfilesModel(
      username: json['subreddit']['title'] as String,
      description: json['subreddit']['public_description'] as String,
      picture: json['subreddit']['icon_img'] as String,
    );
  }
}
