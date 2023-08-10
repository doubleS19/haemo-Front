import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/user_model.dart';

import '../../common/color.dart';
import '../../common/theme.dart';
import '../components/customAppBar.dart';

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
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          children: [
            Text(
                widget.hotPlacePost.title,
              style: CustomThemes.mainTheme.textTheme.headlineMedium,
            ),
            profile(widget.hotPlacePost.nickname),
            const Image(
              image: AssetImage('assets/images/sunset.jpg'),
            ),
            Text(
                widget.hotPlacePost.content
            )
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
