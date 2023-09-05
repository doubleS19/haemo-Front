class WishCLub {
  final int cpId;
  final int uId;

  WishCLub({required this.cpId, required this.uId});

  factory WishCLub.fromJson(Map<String, dynamic> json) {
    return WishCLub(uId: json['uid'], cpId: json['cpId']);
  }

  Map<String, dynamic> toJson() => {'uid': uId, 'cpId': cpId};
}
