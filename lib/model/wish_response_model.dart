class WishResponse {
  final int wId;
  final int pId;
  final int uId;

  WishResponse({required this.wId, required this.pId, required this.uId});

  factory WishResponse.fromJson(Map<String, dynamic> json) {
    return WishResponse(wId: json['wid'], uId: json['uid'], pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {'wid': wId, 'uid': uId, 'pid': pId};
}
