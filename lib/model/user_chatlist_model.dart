class UserChatList {
  String uId;
  List<String>? chatList;

  UserChatList({
    required this.uId,
    required this.chatList
  });


  Map<String, dynamic> toJson() {
    return {
      'uid': uId,
      'chatlist': chatList,
    };
  }

  factory UserChatList.fromJson(Map<String, dynamic> json) {
    return UserChatList(
      uId: json['uid'],
      chatList: List<String>.from(json['chatlist']),
    );
  }
}