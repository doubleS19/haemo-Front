import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/common/user_image.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/userBottomSheet.dart';
import 'package:hae_mo/utils/shared_preference.dart';

Row userProfile(BuildContext context, UserResponse user, String date) {
  final iconColor =
      user.gender == "남자" ? AppTheme.blueColor : AppTheme.pinkColor;
  return Row(
    children: [
      SizedBox(
          width: 41.0,
          height: 41.0,
          child: RawMaterialButton(
              elevation: 0.0,
              fillColor: Colors.transparent,
              shape: const CircleBorder(),
              onPressed: (() {
                userBottomSheet(context, user);
              }),
              child: Container(
                width: 41,
                height: 41,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(userRoundImage[user.userImage]),
                  ),
                ),
              ))),
      const SizedBox(width: 10.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user.nickname,
            style: TextStyle(
              fontSize: 13.0,
              color: AppTheme.mainTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                '${user.major} / ',
                style: TextStyle(
                  fontSize: 10.0,
                  color: AppTheme.mainTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(Icons.favorite, size: 12.0, color: iconColor),
              Text(
                " / ${date.replaceAll("년 ", ".").replaceAll("월 ", ".").replaceAll("일", "")}",
                style: TextStyle(
                  fontSize: 10.0,
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
