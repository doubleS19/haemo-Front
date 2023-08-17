import 'package:flutter/material.dart';
import 'package:hae_mo/common/theme.dart';

import '../../common/color.dart';

void showMyAlertDialog(BuildContext context, String title, String content) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Center(child: Text(content)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

void showYesOrNoDialog(BuildContext context, String content, String cancel,
    String confirm, Function onClick) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text(content, style: CustomThemes.customDialogContentTextStyle),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
                child: Container(
                  height: 35,
                  margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
                    decoration:
                        BoxDecoration(color: AppTheme.settingPageDividerColor, borderRadius: BorderRadius.circular(8.0)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(cancel,
                          style:
                              CustomThemes.customDialogCancelButtonTextStyle),
                    ))),
            Expanded(
                child: Container(
                  height: 35,
                  margin: EdgeInsets.fromLTRB(6, 0, 6, 6),
                  decoration:
                      BoxDecoration(color: CustomThemes.mainTheme.primaryColor, borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    onPressed: () => onClick,
                    child: Text(confirm,
                        style: CustomThemes.customDialogConfirmButtonTextStyle),
                  ),
                )),
          ],
        )
      ],
    ),
  );
}
