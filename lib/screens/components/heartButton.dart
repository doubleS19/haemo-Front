import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({super.key, required this.fillHeart, required this.onClick});

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
        setState(() {
          print("여긴 클릭이 되거든? 근데..");
          widget.onClick;
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