import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/service/db_service.dart';

import '../../model/wish_model.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key, required this.fillHeart, required this.onClick});

  final bool fillHeart;
  final void Function()? onClick;
  @override
  _HeartButtonWidgetState createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  late bool fillHeartColor;
  @override
  void initState() {
    super.initState();
    fillHeartColor = widget.fillHeart;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        DBService db = DBService();
        Wish wish = Wish(uId: 42, pId: 1);
        db.addWishList(wish);
        setState(() {
          print("여긴 클릭이 되거든? 근데..");
          widget.onClick;

          /// 클릭 후 디비에 반영되면 색이 바뀌도록 바꿔야 될지도..?
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
