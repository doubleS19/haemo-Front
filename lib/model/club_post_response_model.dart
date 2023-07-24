class ClubPostResponse {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final String category;
  final int pId;

  ClubPostResponse(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.category,
      required this.pId});

  factory ClubPostResponse.fromJson(Map<String, dynamic> json) {
    return ClubPostResponse(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        category: json['category'],
        pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'category': category,
        'pid': pId
      };
}