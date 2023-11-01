import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class AppVersionController extends GetxController {
  RxString version = ''.obs;

  Future<void> fetchAppVersion() async {
    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      version.value = info.version;
    } catch (error) {
      print(error.toString());
    }
  }
}
