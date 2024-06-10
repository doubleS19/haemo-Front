class PostBase {
  String nickname;
  String title;
  String content;
  int wishCnt = 0;

  PostBase(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.wishCnt});
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
      required String date,
      required int wishCnt})
      : super(
          nickname: nickname,
          title: title,
          content: content,
          wishCnt: 0,
        );

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        deadline: json['deadline'],
        date: json['date'],
        wishCnt: 0);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'deadline': deadline,
        'date': date,
        'wishCnt': wishCnt
      };
}
