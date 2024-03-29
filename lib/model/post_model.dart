class PostBase {
  String nickname;
  String title;
  String content;

  PostBase({
    required this.nickname,
    required this.title,
    required this.content,
  });
}

class Post extends PostBase {
  late int person;
  late String category;
  late String deadline;
  late String date;

  Post(
      {required String nickname,
      required String title,
      required String content,
      required int person,
      required String category,
      required String deadline,
      required String date})
      : super(
          nickname: nickname,
          title: title,
          content: content,
        );

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        deadline: json['deadline'],
        date: json['date']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'deadline': deadline,
        'date': date
      };
}
