import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum ImageType { logo, hotPlaceImgList }

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RxList<XFile> _pickedImgs = RxList<XFile>([]);

  List<XFile> get pickedImgs => _pickedImgs;

  final Rx<XFile?> _pickedImg = Rx<XFile?>(null);

  XFile? get pickedImg => _pickedImg.value;

  late ImageType imgType;
  late bool isLoading;

  ImageController(ImageType type) {
    imgType = type;
  }

  Future<List<XFile>> pickImageGallery() async {
    List<XFile> images = [];
    if (imgType == ImageType.hotPlaceImgList) {
      try {
        isLoading = true;
        images = await _picker.pickMultiImage();
        Future.delayed(const Duration(seconds: 2));
        if (images == null) {
          print('이미지가 선택되지 않았습니다');
          return [];
        }
        if (pickedImgs.length + images.length <= 4) {
          /// 이미지 개수가 너무 많다는 다이얼로그 필요
          _pickedImgs.addAll(images);
        }
        print('이미지 리스트 개수: ${pickedImgs.length}');
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }finally{
        isLoading = false;
        update();
      }
    } else {
/*      try {
        XFile? images = await _picker.pickImage(source: ImageSource.gallery);
        if (images == null) {
          print('이미지가 선택되지 않았습니다');
          return [];
        }
        _pickedImg.value = images;
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      } finally{
        update();
      }
      return images;*/
    }
    return images;
  }

  deleteImages(int index) {
    if (imgType == ImageType.hotPlaceImgList) {
      _pickedImgs.removeAt(index); // 삭제되면 true, 실패하면 false
    } else {
      _pickedImg == null;
    }
  }
}
