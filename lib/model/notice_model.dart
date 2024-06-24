class Notice {
  String title;
  String content;
  String date;
  String noticeType;
  bool visible;

  Notice({
    required this.title,
    required this.content,
    required this.date,
    required this.noticeType,
    required this.visible,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'content': content,
      'date': date,
      'type': noticeType,
      'visible': visible,
    };

    return data;
  }

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      title: json['title'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
      noticeType: json['type'] as String,
      visible: json['visible'] as bool,
    );
  }
}
