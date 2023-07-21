import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color.dart';
import '../../controller/image_controller.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({Key? key}) : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
        init: ImageController(),
        builder: (_) {
          return Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                itemCount: _.pickedImgs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: changeButtonToImage(context, index, _));
                  //galleryButton(context, index, _)
                },
              ));
        });
  }
}

Widget changeButtonToImage(dynamic context,
    int index,
    ImageController imgController,) {
  if (index >= 4) {
    return Container();
  }
  if (index >= imgController.pickedImgs.length) {
    return SizedBox(
        width: 80,
        height: 80,
        child: galleryButton(context, "$index/4", imgController));
  } else {
    // 선택된 이미지
    return pickedImageContainer(index, imgController);
  }
}

Widget changeButtonToLogo(dynamic context, ImageController imgController){
  if (imgController.pickedImg == null) {
    return SizedBox(
        width: 80,
        height: 80,
        child: galleryButton(context, "로고", imgController));
  } else {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            image: DecorationImage(
              image: FileImage(File(imgController.pickedImg!.path)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              imgController.deleteImage();
              imgController.update();
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget galleryButton(BuildContext context, String buttonText,
    ImageController imgController) {
  return OutlinedButton(
    onPressed: () {
      imgController.pickImagesGallery();
    },
    onFocusChange: null,
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(13)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo,
            color: AppTheme.postingPageDetailHintTextColor,
          ),
          Text(
            buttonText,
            style: Theme
                .of(context)
                .textTheme
                .bodySmall,
          ),
        ],
      ),
    ),
  );
}

Widget pickedImageContainer(int index, ImageController imgController){
  return Stack(
    children: [
      Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          image: DecorationImage(
            image: FileImage(File(imgController.pickedImgs[index].path)),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            imgController.deleteImages(index);
            imgController.update();
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );
}