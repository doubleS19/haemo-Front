class PostResponse {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final String date;
  final int type;
  final int pId;

  PostResponse(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.date,
      required this.type,
      required this.pId});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        date: json['date'],
        type: json['type'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'date': date,
        'type': type,
        'pid': pId
      };
}
