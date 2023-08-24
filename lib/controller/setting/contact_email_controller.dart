import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../service/db_service.dart';


class ContactEmailController extends GetxController {
  final DBService dbService = DBService();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  late Email email;
  Rx<String> contactType = "".obs;

  // flutter: Error sending email: PlatformException(not_available, No email clients found!, null, null) -> 시뮬 사용시 에

  void sendEmail() async {
    try {
      Email email = Email(
        body: contentTextEditingController.text,
        subject: contactType.value,
        recipients: ["happysy@gmail.com"],
        cc:[],
        bcc:[],
        attachmentPaths: [],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } catch (error) {
      print("Error sending email: $error");
    }
  }


}
