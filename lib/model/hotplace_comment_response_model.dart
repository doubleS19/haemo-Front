class HotPlaceCommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;
  final int type;

  HotPlaceCommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId,
      required this.type});

  factory HotPlaceCommentResponse.fromJson(Map<String, dynamic> json) {
    return HotPlaceCommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json['cid'],
        pId: json['hpId'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        'cid': cId,
        'hpId': pId,
        'type': type
      };
}
