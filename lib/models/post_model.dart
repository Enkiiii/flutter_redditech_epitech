class PostsModel {
  final String title;
  final String author;
  final String date;
  final String subRedditName;
  final String type;
  final String media;

  // Required ou this.THING = "" : est nécessaire au bon fonctionnement

  PostsModel(
      {required this.title,
      required this.author,
      required this.date,
      required this.subRedditName,
      required this.type,
      required this.media});

  PostsModel.fromJson(
      Map<String, dynamic> json, this.type, this.media, this.date)
      : title = json['data']['title'],
        author = "u/${json['data']['author']}",
        subRedditName = json['data']['subreddit_name_prefixed'];
}
