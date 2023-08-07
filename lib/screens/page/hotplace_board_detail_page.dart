import 'package:flutter/cupertino.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/user_model.dart';

import '../../common/color.dart';

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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          profile(widget.hotPlacePost.nickname),
          const Image(
            image: AssetImage('assets/images/sunset.jpg'),
          ),
          Text(
            widget.hotPlacePost.content
          )
        ],
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
