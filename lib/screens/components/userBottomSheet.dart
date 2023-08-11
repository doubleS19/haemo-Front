import 'package:flutter/material.dart';

void userBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: double.infinity * 0.4,
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(child: Container()),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Color(0xff393939),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Expanded(child: Text("텍스트")),
          ],
        ),
      );
    },
  );
}
