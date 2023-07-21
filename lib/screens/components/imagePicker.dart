import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/color.dart';
import '../../controller/image_controller.dart';
import '../../controller/posting_controller.dart';

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
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                itemCount: _.pickedImgs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: galleryButton(context, index, _));
                  //galleryButton(context, index, _)
                },
              ));
        });
  }
}

Widget galleryButton(
  dynamic context,
  int index,
  ImageController imgController,
) {
  if (index >= 4) {
    return Container();
  }
  if (index >= imgController.pickedImgs.length) {
    return Container(
        width: 80,
        height: 80,
        child: OutlinedButton(
          onPressed: () {
            imgController.pickImageCamera();
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
                  "$index/4",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ));
  } else {
    // 선택된 이미지
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
        Text(
          index.toString(),
          style: TextStyle(color: Colors.red),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              imgController.deleteImage(index);
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
