import 'package:get/get.dart';

class NoticeVisibilityController extends GetxController {
  var isVisible = true.obs;

  void toggleVisibility() {
    isVisible.toggle();
  }
}
