
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  getData(){
    var result = firestore.collection('haemo').doc('Koq0ZXc2Scnj1n6VcOyi').snapshots();

    return result;
  }

  @override
  void onInit(){
    super.onInit();
    getData();
  }

}