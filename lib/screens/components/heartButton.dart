import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haemo/model/wish_response_model.dart';
import 'package:haemo/service/db_service.dart';

import '../../model/wish_model.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({super.key, required this.uId, required this.pId});

  final int uId;
  final int pId;

  @override
  _HeartButtonWidgetState createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
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
    var wishResponseList = await db.getWishListByUser(widget.uId);

    return wishResponseList.any((item) => item.pId == widget.pId);
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
