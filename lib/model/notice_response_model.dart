class NoticeResponse {
  String title;
  String content;
  String MD;
  String date;
  String noticeType;
  bool visible;

  NoticeResponse(
      {required this.title,
      required this.content,
      required this.MD,
      required this.date,
      required this.noticeType,
      required this.visible});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'content': content,
      'md': MD,
      'date': date,
      'type': noticeType,
      'visible': visible,
    };

    return data;
  }

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
        title: json['title'] as String,
        content: json['content'] as String,
        MD: json['md'] as String,
        date: json['date'] as String,
        noticeType: json['type'] as String,
        visible: json['visible'] as bool);
  }
}
