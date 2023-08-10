class Wish {
  final int wId;
  final int pId;
  final int uId;

  Wish({required this.wId, required this.pId, required this.uId});

  factory Wish.fromJson(Map<String, dynamic> json) {
    return Wish(wId: json['wid'], uId: json['uid'], pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {'wid': wId, 'uid': uId, 'pid': pId};
}
