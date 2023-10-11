import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/post_type.dart';
import 'package:hae_mo/model/user_model.dart';

import '../../../common/color.dart';
import '../../../common/theme.dart';
import '../../components/commentWidget.dart';
import '../../components/customAppBar.dart';

class HotPlaceDetailPage extends StatefulWidget {
  const HotPlaceDetailPage({Key? key, required this.hotPlacePost})
      : super(key: key);

  final HotPlacePostResponse hotPlacePost;

  @override
  State<HotPlaceDetailPage> createState() => _HotPlaceDetailPageState();
}

class _HotPlaceDetailPageState extends State<HotPlaceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  children: [
                    profile(widget.hotPlacePost.nickname),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.hotPlacePost.title,
                              style: CustomThemes.hotPlaceBoardTitleTextStyle,
                            ),
                            Text("정왕동",
                                style:
                                    CustomThemes.mainTheme.textTheme.bodySmall)
                          ],
                        )),
                  ],
                )),
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.mainTextColor,
                image: const DecorationImage(
                  image: AssetImage('assets/images/sunset.jpg'),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(widget.hotPlacePost.content)),
            Divider(color: CustomThemes.mainTheme.dividerColor),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: commentWidget(widget.hotPlacePost.pId, 3))
          ],
        ),
      ),
    );
  }
}

Widget profile(String nickname) {
  return Row(
    children: [
      Container(
        width: 41,
        height: 41,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.mainTextColor,
          image: const DecorationImage(
            image: AssetImage('assets/images/sunset.jpg'),
          ),
        ),
      ),
      const SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nickname,
            style: TextStyle(
              fontSize: 12.0,
              color: AppTheme.mainTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                '${nickname}  /  ',
                style: TextStyle(
                  fontSize: 12.0,
                  color: AppTheme.mainTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                nickname,
                style: TextStyle(
                  fontSize: 12.0,
                  color: AppTheme.mainTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
