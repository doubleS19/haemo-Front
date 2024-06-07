import 'dart:typed_data';

class ClubPostResponse {
  final String nickname;
  final String title;
  final String content;
  final int person;
  final int pId;
  final String description;
  final String? logo;
  final String date;

  ClubPostResponse(
      {required this.nickname,
      required this.title,
      required this.content,
      required this.person,
      required this.description,
      required this.pId,
      required this.logo,
      required this.date});

  factory ClubPostResponse.fromJson(Map<String, dynamic> json) {
    return ClubPostResponse(
        nickname: json['nickname'],
        title: json['title'],
        content: json['content'],
        person: json['person'],
        description: json['description'],
        pId: json['cpId'],
        logo: json["logo"],
        date: json["date"]);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'title': title,
        'content': content,
        'person': person,
        'description': description,
        'cpId': pId,
        'logo': logo,
        'date': date
      };
}
