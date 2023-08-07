class Wish {
  final int pId;
  final int uId;

  Wish({required this.pId, required this.uId});

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(uId: json['uid'], pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {'uid': uId, 'pid': pId};
}
