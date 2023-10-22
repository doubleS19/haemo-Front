enum CommentResponseType { Post, Club, HotPlace }

class CommentResponse {
  final String content;
  final String nickname;
  final String date;
  final int pId;
  final int cId;
  final CommentResponseType type;

  CommentResponse(
      {required this.content,
      required this.nickname,
      required this.date,
      required this.cId,
      required this.pId,
      required this.type});

  factory CommentResponse.fromJson(
      Map<String, dynamic> json, CommentResponseType type) {
    return CommentResponse(
        content: json['content'],
        nickname: json['nickname'],
        date: json['date'],
        cId: json[type == CommentResponseType.Post
            ? 'cid'
            : (type == CommentResponseType.Club ? 'ccId' : 'hcId')],
        pId: json[type == CommentResponseType.Post
            ? 'pid'
            : (type == CommentResponseType.Club ? 'cpId' : 'hpId')],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'nickname': nickname,
        'date': date,
        if (type == CommentResponseType.Post) 'pid': pId,
        if (type == CommentResponseType.Post) 'cid': cId,
        if (type == CommentResponseType.Club) 'cpId': pId,
        if (type == CommentResponseType.Club) 'ccId': cId,
        if (type == CommentResponseType.HotPlace) 'hpId': pId,
        if (type == CommentResponseType.HotPlace) 'hcId': cId
      };
}
