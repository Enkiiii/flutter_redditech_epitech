class SubredditSearchModel {
  final String title;
  final String img;

  SubredditSearchModel({required this.title, required this.img});

  SubredditSearchModel.fromJson(Map<String, dynamic> json)
      : title = json['kind'] == "t5"
            ? json['data']['display_name_prefixed']
            : json['data']['name'],
        img = json['kind'] == "t5"
            ? (json['data']['icon_img'] != '' &&
                    json['data']['icon_img'] != null)
                ? json['data']['icon_img']
                : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png"
            : (json['data']['snoovatar_img'] != '' &&
                    json['data']['snoovatar_img'] != null)
                ? json['data']['snoovatar_img']
                : "https://upload.wikimedia.org/wikipedia/fr/thumb/f/fc/Reddit-alien.png/220px-Reddit-alien.png";
}
