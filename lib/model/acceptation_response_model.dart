class AcceptationResponse {
  final int aId;
  final int pId;
  final int uId;
  final bool isAccepted;

  AcceptationResponse(
      {required this.aId,
      required this.pId,
      required this.uId,
      required this.isAccepted});

  factory AcceptationResponse.fromJson(Map<String, dynamic> json) {
    return AcceptationResponse(
        aId: json['aid'],
        uId: json['uid'],
        pId: json['pId'],
        isAccepted: json['accept']);
  }

  Map<String, dynamic> toJson() =>
      {'aid': aId, 'uid': uId, 'pId': pId, 'accept': isAccepted};
}
