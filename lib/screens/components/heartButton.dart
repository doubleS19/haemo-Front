import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget({super.key, required this.fillHeart});

  final bool fillHeart;
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