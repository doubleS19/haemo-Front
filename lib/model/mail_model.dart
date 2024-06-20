class Mail {
  String subject;
  String body;

  Mail({
    required this.subject,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'subject': subject,
      'body': body,
    };
    return data;
  }

  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
      subject: json['subject'],
      body: json['body'],
    );
  }
}
