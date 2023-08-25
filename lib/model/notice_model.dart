class NoticeModel {
  String title;
  String content;
  String MD;
  String date;
  String noticeType;
  bool visible;

  NoticeModel({
    required this.title,
    required this.content,
    required this.MD,
    required this.date,
    required this.noticeType,
    required this.visible
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'title': title,
      'content': content,
      'MD': MD,
      'date': date,
      'noticeType': noticeType,
      'visible': visible,
    };

    return data;
  }

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      title: json['title'] as String,
      content: json['content'] as String,
      MD: json['MD'] as String,
      date: json['date'] as String,
      noticeType: json['noticeType'] as String,
      visible: json['visible'] as bool
    );
  }
}
