import 'package:flutter/material.dart';

import '../../common/color.dart';

final headCountList = ["0명", "1명", "2명", "3명", "4명", "5명 이상"];
final categoryList = ["술", "미팅", "밥"];

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {Key? key, required this.list, required this.basicType})
      : super(key: key);

  final List<dynamic> list;
  final String basicType;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = widget.list;
    String? selectedValue = list[0];

    return Padding(
        padding: const EdgeInsets.all(5),
        child: DropdownButtonHideUnderline(
            child: DropdownButton(
          //padding: EdgeInsets.all(30),
          value: selectedValue,
          /*hint: Text(widget.basicType,
              style: Theme.of(context).textTheme.bodySmall),*/
          menuMaxHeight: 150,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: list.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value as String?;
            });
          },
        )));
  }
}

Widget dropDownButtonWidth(double width, Widget dropDownButton) {
  return Container(
      height: 35,
      width: width,
      //padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: AppTheme.postingPageDetailTextFieldColor),
          borderRadius: const BorderRadius.all(Radius.circular(6.0))),
      child: dropDownButton);
}
