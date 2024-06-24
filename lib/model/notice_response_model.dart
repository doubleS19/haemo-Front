class NoticeResponse {
  int nId;
  String title;
  String content;
  String date;
  String noticeType;
  bool visible;

  NoticeResponse(
      {required this.nId,
      required this.title,
      required this.content,
      required this.date,
      required this.noticeType,
      required this.visible});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'nid': nId,
      'title': title,
      'content': content,
      'date': date,
      'type': noticeType,
      'visible': visible,
    };

    return data;
  }

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
        nId: json['nid'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        date: json['date'] as String,
        noticeType: json['type'] as String,
        visible: json['visible'] as bool);
  }
}
