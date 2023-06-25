import 'dart:async';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screens/Page/chat_list_page.dart';
import '../model/chatlist_model.dart';

class ChatListController extends GetxController {
  List<ChatList> chatList = [];
  StreamController streamController = StreamController();

  @override
  void onInit() {
    super.onInit();
  }

  void addChatList(){
  }


}
