class ClubPost {
  String nickname;
  String title;
  String content;
  int person;
  String category;

  ClubPost(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category});

  factory ClubPost.fromJson(Map<String, dynamic> json) {
    return ClubPost(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category
      };
}
