import 'package:get/get_connect/connect.dart';

import '../model/login_model.dart';

class LoginService extends GetConnect {
  final String loginUrl = '';
  final String registerUrl = '';

  Future fetchLogin(LoginRequestModel model) async {
    final response = await post(loginUrl, model.toJson());

    /// 로그인 기능 추가하기
/*    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.body);
    } else {
      return null;
    }*/
  }
}
