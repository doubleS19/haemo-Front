

import 'package:flutter/material.dart';

import '../../common/color.dart';

Widget selectPictureButton(int pictureNum, dynamic context){
  return Container(
    //width: MediaQuery.of(context).
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
  alignment: Alignment.center,
  decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  //color: AppTheme.postingPageDetailTextFieldColor,
  ),
  child:OutlinedButton(
    onPressed: (){
      
    },
    onFocusChange: null,
    child: Column(children: [
      Icon(Icons.photo, color: AppTheme.postingPageDetailHintTextColor,),
      Text("$pictureNum/4", style: Theme.of(context).textTheme.bodySmall,
    ),

  ]),
  ) 
  );
}