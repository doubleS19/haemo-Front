import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hae_mo/utils/shared_preference.dart';

import '../common/color.dart';

Map<int, ThemeType> colorTheme = {
  0: ThemeType.Blue,
  1: ThemeType.Beige,
  2: ThemeType.Pink,
  3: ThemeType.LightGreen
};

class SettingScreenThemeController extends GetxController {
  final RxList<bool> isCheckedList = [true, false, false, false].obs;
  ThemeType themeType = AppTheme.themeType.value;

  void changeTheme(int selectedIndex) {
    AppTheme.changeThemeType(colorTheme[selectedIndex]??ThemeType.Blue);
    PreferenceUtil.setInt("colorTheme", selectedIndex);
  }

  void selectOneSwitch(int selectedIndex) {
    for (int i = 0; i < isCheckedList.length; i++) {
      isCheckedList[i] = (i == selectedIndex);
    }
  }
  void rollBackColor(){

  }
}
