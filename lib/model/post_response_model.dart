class PostResponse {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final String date;
  final String deadline;
  final int pId;

  PostResponse(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.date,
      required this.deadline,
      required this.pId});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        date: json['date'],
        deadline: json['deadline'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'date': date,
        'deadline': deadline,
        'pid': pId
      };
}
