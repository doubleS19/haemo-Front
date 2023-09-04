class WishMeeting {
  final int pId;
  final int uId;

  WishMeeting({required this.pId, required this.uId});

  factory WishMeeting.fromJson(Map<String, dynamic> json) {
    return WishMeeting(uId: json['uid'], pId: json['pid']);
  }

  Map<String, dynamic> toJson() => {'uid': uId, 'pid': pId};
}
