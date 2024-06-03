class LoginRequestModel {
  String? id;
  String? password;

  LoginRequestModel({this.id, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['studentId'] = id;
    data['pwd'] = password;
    return data;
  }
}

class LoginResponseModel {
  String? token;

  LoginResponseModel({this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }
}
