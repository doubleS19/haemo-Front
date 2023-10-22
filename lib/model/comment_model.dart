enum CommentType { Post, Club, HotPlace }

class Comment {
  final String nickname;
  final String content;
  final String date;
  final int pId;
  final CommentType type;

  Comment(
      {required this.nickname,
      required this.content,
      required this.date,
      required this.pId,
      required this.type});

  factory Comment.fromJson(Map<String, dynamic> json, CommentType type) {
    return Comment(
        nickname: json['nickname'],
        content: json['content'],
        date: json['date'],
        pId: json[type == CommentType.Post
            ? 'pid'
            : (type == CommentType.Club ? 'cpId' : 'hpId')],
        type: type);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'content': content,
        'date': date,
        if (type == CommentType.Post) 'pid': pId,
        if (type == CommentType.Club) 'cpId': pId,
        if (type == CommentType.HotPlace) 'hpId': pId
      };
}
