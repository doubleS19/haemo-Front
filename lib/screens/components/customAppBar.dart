
import 'package:flutter/material.dart';

Widget customAppbar(String appBarText) {
  return Builder(
      builder: (context) => AppBar(
          title: Text(appBarText, style: Theme.of(context).textTheme.headlineMedium),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          actions: const <Widget>[
/*            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.navigate_before))*/
          ]));
}
