enum CommentType { Post, Club, HotPlace }

class CommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;
  final CommentType type;

  CommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId,
      required this.type});

  factory CommentResponse.fromJson(
      Map<String, dynamic> json, CommentType type) {
    return CommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json[type == CommentType.Post
            ? 'cid'
            : (type == CommentType.Club ? 'ccId' : 'hcId')],
        pId: json[type == CommentType.Post
            ? 'pid'
            : (type == CommentType.Club ? 'cpId' : 'hpId')],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        if (type == CommentType.Post) 'pid': pId,
        if (type == CommentType.Post) 'cid': cId,
        if (type == CommentType.Club) 'cpId': pId,
        if (type == CommentType.Club) 'ccId': cId,
        if (type == CommentType.HotPlace) 'hpId': pId,
        if (type == CommentType.HotPlace) 'hcId': cId
      };
}
