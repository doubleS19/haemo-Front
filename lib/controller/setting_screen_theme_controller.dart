import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../common/color.dart';

class SettingScreenThemeController extends GetxController{
  final RxList<bool> isCheckedList = [true, false, false, false].obs;
  ThemeType themeType = AppTheme.themeType;


  void changeTheme(){
    AppTheme.changeThemeType(themeType);
  }

  void selectOneSwitch(int selectedIndex) {
    for (int i = 0; i < isCheckedList.length; i++) {
      isCheckedList[i] = (i == selectedIndex);
    }
  }

}