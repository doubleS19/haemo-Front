import 'package:flutter/material.dart';

void showMyAlertDialog(BuildContext context, String title, String content) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('닫기'),
        ),
      ],
    ),
  );
}
