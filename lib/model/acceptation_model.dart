class AcceptationResponse {
  final int pId;
  final int uId;
  final bool isAccepted;

  AcceptationResponse(
      {required this.pId, required this.uId, required this.isAccepted});

  factory AcceptationResponse.fromJson(Map<String, dynamic> json) {
    return AcceptationResponse(
        uId: json['uid'], pId: json['pId'], isAccepted: json['accept']);
  }

  Map<String, dynamic> toJson() =>
      {'uid': uId, 'pId': pId, 'accept': isAccepted};
}
