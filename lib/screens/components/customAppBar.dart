import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget customAppbar(String appBarText) {
  return Builder(
      builder: (context) => AppBar(
            title: Text(appBarText,
                style: Theme.of(context).textTheme.headlineMedium),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
              },
              color: Theme.of(context).iconTheme.color,
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ));
}
