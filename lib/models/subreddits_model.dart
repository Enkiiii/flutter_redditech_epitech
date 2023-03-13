class SubredditModel {
  final String name;
  final String communityIcon;
  final String bannerBackgroundImage;
  final String description;
  final int subscribers;
  final String title;
  final bool subscribed;

  SubredditModel({
    required this.name,
    required this.communityIcon,
    required this.bannerBackgroundImage,
    required this.description,
    required this.subscribers,
    required this.title,
    required this.subscribed
  });

  SubredditModel.fromJson(Map<String, dynamic> json)
      : name = json['data']['name'],
        communityIcon = json['data']['community_icon'].toString().replaceAll("amp;", ""),
        bannerBackgroundImage = json['data']['banner_background_image'].toString().replaceAll("amp;", ""),
        description = json['data']['public_description'],
        subscribers = json['data']['subscribers'],
        title = json['data']['title'],
        subscribed = json['data']['user_is_subscriber'];
  
}
