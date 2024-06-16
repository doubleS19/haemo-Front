import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/model/wish_club_model.dart';
import 'package:haemo/model/wish_meeting_model.dart';
import 'package:haemo/service/db_service.dart';

class WishStarButton extends StatefulWidget {
  const WishStarButton(
      {super.key, required this.uId, required this.pId, required this.type});

  final int uId;
  final int pId;
  final int type;
  @override
  _WishStarButtonState createState() => _WishStarButtonState();
}

class _WishStarButtonState extends State<WishStarButton> {
  bool fillHeartColor = false;
  DBService db = DBService();

  @override
  void initState() {
    super.initState();
    _fetchWishList().then((result) {
      setState(() {
        fillHeartColor = result;
      });
    });
  }

  Future<bool> _fetchWishList() async {
    var wishResponseList = widget.type == 1
        ? await db.checkWishMeetingExist(widget.uId, widget.pId)
        : await db.checkWishClubExist(widget.uId, widget.pId);

    return wishResponseList;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!fillHeartColor) {
          if (widget.type == 1) {
            WishMeeting wish = WishMeeting(uId: widget.uId, pId: widget.pId);
            db.addWishMeetingList(wish);
          } else {
            WishClub wish = WishClub(uId: widget.uId, cpId: widget.pId);
            db.addWishClubList(wish);
          }
        } else {
          if (widget.type == 1) {
            db.deleteWishMeetingList(widget.uId, widget.pId);
          } else {
            db.deleteWishClubList(widget.uId, widget.pId);
          }
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
