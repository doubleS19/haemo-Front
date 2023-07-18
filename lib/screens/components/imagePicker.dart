import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/color.dart';
import '../../controller/image_controller.dart';
import '../../controller/posting_controller.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({Key? key}) : super(key: key);

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageController>(
        init: ImageController(),
        builder: (_) {
          return Container(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _.pickedImgs.length,
                  itemBuilder: (BuildContext context, int index) {

                  }));
        });
  }
}

/// PostingPage 사진 첨부 버튼
Widget galleryButton(
    int pictureNum, dynamic context, PostController postController) {
  return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        //border: Bord,
        borderRadius: BorderRadius.circular(13),
      ),
      child: OutlinedButton(
        onPressed: () {
          ImageController().pickImageCamera();
        },
        onFocusChange: null,
        //style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.photo,
                color: AppTheme.postingPageDetailHintTextColor,
              ),
              Text(
                "$pictureNum/4",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ])),
      ));
}
