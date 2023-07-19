class Post {
  String nickname;
  String title;
  String content;
  int person;
  String category;
  String date;

  Post(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.date});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'date': date
      };
}
