import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = [];
  get pickedImgs => _pickedImgs;

  Future<void> pickImageCamera() async {
    try {
      List<XFile> images = await _picker.pickMultiImage();
      if (images == null) return;
      _pickedImgs = images;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    update();
  }

  deleteImage(int index){
    return _pickedImgs.removeAt(index); // 삭제되면 true, 실패하면 false
  }
}
