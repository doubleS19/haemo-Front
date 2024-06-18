import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:haemo/controller/posting_controller.dart';
import 'package:haemo/model/post_type.dart';
import 'package:image_picker/image_picker.dart';
import '../../common/color.dart';
import '../../common/theme.dart';
import '../../controller/image_controller.dart';
import 'customIndicator.dart';

class CustomImagePicker extends StatefulWidget {
  const CustomImagePicker({Key? key, required this.imgType}) : super(key: key);

  final ImageType imgType;

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker>
    with AutomaticKeepAliveClientMixin<CustomImagePicker> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    PostType postType =
        widget.imgType == ImageType.logo ? PostType.club : PostType.hotPlace;
    PostController postController = PostController(postType);

    return GetBuilder<ImageController>(
        init: ImageController(widget.imgType),
        builder: (_) {
          if (widget.imgType == ImageType.hotPlaceImgList) {
            return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // Enable horizontal scrolling
                  itemCount: _.pickedImgs.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _.pickedImgs.length) {
                      if (index == 4) {
                        return Container();
                      } else {
                        return SizedBox(
                            width: 80,
                            height: 80,
                            child:
                                galleryButton(context, index.toString(), _, () {
                              _.pickImageGallery().then((value) =>
                                  postController.img.value =
                                      value.obs as String);
                              setState(() {
                                postController.img.value = _.imageSrc.obs.value;
                              });
                            }));
                      }
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: pickedImageContainer(index, _));
                    }
                  },
                ));
          } else {
            return changeButtonToLogo(context, _, () {
              _.pickImageGallery();
              setState(() {
                postController.img.value = _.imageSrc.obs.value;
              });
              print("포스트 컨트롤러 변경됐나? ${postController.img.obs.value}");
            });
          }
        });
  }
}

Widget changeButtonToLogo(
    dynamic context, ImageController imgController, Function onClicked) {
  if (imgController.pickedImg == null) {
    return SizedBox(
        width: 80,
        height: 80,
        child: galleryButton(context, "로고", imgController, () {
          onClicked();
        }));
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
              imgController.deleteImages(0);
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
    ImageController imgController, Function onClicked) {
  return OutlinedButton(
    onPressed: () {
      onClicked();
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
            "$buttonText",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

Widget pickedImageContainer(int index, ImageController imgController) {
  final imageFile = File(imgController.pickedImgs[index].path);

  return FutureBuilder<void>(
    future: imgController.pickedImgs == null
        ? Future.value()
        : Future.delayed(Duration(milliseconds: 500)),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
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
                  image: FileImage(imageFile),
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
      } else {
        return Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          child: customIndicator(30, 0),
        );
      }
    },
  );
}
