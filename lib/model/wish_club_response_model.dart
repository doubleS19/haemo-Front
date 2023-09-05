class WishClubResponse {
  final int wcId;
  final int cpId;
  final int uId;

  WishClubResponse({required this.wcId, required this.cpId, required this.uId});

  factory WishClubResponse.fromJson(Map<String, dynamic> json) {
    return WishClubResponse(
        wcId: json['wcId'], uId: json['uid'], cpId: json['cpId']);
  }

  Map<String, dynamic> toJson() => {'wcId': wcId, 'uid': uId, 'cpId': cpId};
}
