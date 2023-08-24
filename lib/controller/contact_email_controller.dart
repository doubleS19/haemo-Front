import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../service/db_service.dart';


class ContactEmailController extends GetxController {
  final DBService dbService = DBService();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();

  Rx<String> contactType = "".obs;


}
