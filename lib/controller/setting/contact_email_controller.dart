import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:haemo/model/mail_model.dart';
import 'package:haemo/model/user_response_model.dart';
import 'package:haemo/screens/Page/home_page.dart';
import 'package:haemo/utils/shared_preference.dart';
import '../../service/db_service.dart';

class ContactEmailController extends GetxController {
  final DBService dbService = DBService();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  var email = "".obs;
  Rx<String> contactType = "".obs;
  var subject = "".obs;
  var body = "".obs;
  var reportedUser = null;
  var sendMail = false.obs;
  var contactContent = "".obs;
  // flutter: Error sending email: PlatformException(not_available, No email clients found!, null, null) -> 시뮬 사용시 에

  void sendEmail(int type, UserResponse user) async {
    if (type == 1) {
      subject = "WonT 문의".obs;
      body =
          "유저: ${user.uId} \n닉네임: ${user.nickname} \n답변 이메일: ${email.obs.value} \n유형: ${contactType.obs.value}문의 내용: ${contentTextEditingController.text.obs.value}"
              .obs;
    } else {
      subject = "WonT 신고".obs;
      body =
          "신고 유저: ${user.uId} \n닉네임: ${user.nickname}\n신고자: ${PreferenceUtil.getInt("uId")}, 신고자 닉네임: ${PreferenceUtil.getString("nickname")}\n사유: ${contactType.obs.value}\n내용: ${contactContent.obs.value}"
              .obs;
    }
    bool isSended = await dbService
        .sendMail(Mail(subject: subject.value, body: body.value))
        .then((value) => sendMail.value = value);
  }
}
