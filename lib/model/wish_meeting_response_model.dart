class WishMeetingResponse {
  final int wmId;
  final int pId;
  final int uId;

  WishMeetingResponse(
      {required this.wmId, required this.pId, required this.uId});

  factory WishMeetingResponse.fromJson(Map<String, dynamic> json) {
    return WishMeetingResponse(
        wmId: json['wmId'], uId: json['uid'], pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {'wmId': wmId, 'uid': uId, 'pid': pId};
}
