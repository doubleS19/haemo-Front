import 'package:flutter/material.dart';

Widget dropDownButton(
    List<String> categoryList, void Function(String) onChanged) {
  var selectedCategory = categoryList[0];

  return DropdownButton(
    value: selectedCategory,
    items: categoryList.map((value) {
      return DropdownMenuItem(
        value: value,
        child: Text(value),
      );
    }).toList(),
    onChanged: (value) {
      if (value!.isNotEmpty) {
        selectedCategory = value;
        onChanged(value);
      }
    },
  );
}
