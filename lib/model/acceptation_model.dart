class Acceptation {
  final int pId;
  final int uId;
  final bool isAccepted;

  Acceptation({required this.pId, required this.uId, required this.isAccepted});

  factory Acceptation.fromJson(Map<String, dynamic> json) {
    return Acceptation(
        uId: json['uid'], pId: json['pid'], isAccepted: json['accept']);
  }

  Map<String, dynamic> toJson() =>
      {'uid': uId, 'pid': pId, 'accept': isAccepted};
}
