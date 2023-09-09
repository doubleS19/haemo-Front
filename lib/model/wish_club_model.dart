class WishClub {
  final int cpId;
  final int uId;

  WishClub({required this.cpId, required this.uId});

  factory WishClub.fromJson(Map<String, dynamic> json) {
    return WishClub(uId: json['uid'], cpId: json['cpId']);
  }

  Map<String, dynamic> toJson() => {'uid': uId, 'cpId': cpId};
}
