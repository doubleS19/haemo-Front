import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/service/db_service.dart';

import '../../model/wish_model.dart';

class WishStarButton extends StatefulWidget {
  const WishStarButton(
      {super.key,
      required this.fillHeart,
      required this.uId,
      required this.pId});

  final bool fillHeart;
  final int uId;
  final int pId;
  @override
  _WishStarButtonState createState() => _WishStarButtonState();
}

class _WishStarButtonState extends State<WishStarButton> {
  late bool fillHeartColor;
  DBService db = DBService();

  @override
  void initState() {
    super.initState();
    fillHeartColor = widget.fillHeart;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!fillHeartColor) {
          Wish wish = Wish(uId: widget.uId, pId: widget.pId);
          // db.addWishList(wish);
        } else {
          // db.deleteWishList(widget.uId, widget.pId);
        }
        setState(() {
          fillHeartColor = !fillHeartColor;
        });
      },
      icon: Image.asset(
        "assets/icons/wish_meeting_icon.png",
        color: fillHeartColor ? AppTheme.mainColor : AppTheme.dividerColor,
      ),
    );
  }
}