import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/model/wish_response_model.dart';
import 'package:hae_mo/service/db_service.dart';

import '../../model/wish_model.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key,
      required this.fillHeart,
      required this.uId,
      required this.pId});

  final bool fillHeart;
  final int uId;
  final int pId;
  @override
  _HeartButtonWidgetState createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
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
          print("heartButton add");
          db.addWishList(wish);
        } else {
          db.deleteWishList(widget.uId, widget.pId);
          print("heartButton delete");
        }
        setState(() {
          fillHeartColor = !fillHeartColor; // Toggle the value
        });
      },
      icon: Icon(
        CupertinoIcons.heart_fill,
        color: fillHeartColor ? Colors.red : Colors.grey,
      ),
    );
  }
}
