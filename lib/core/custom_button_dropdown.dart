
import 'package:abgtools/constant.dart';
import 'package:flutter/material.dart';

import '../widgets/block_custom_text.dart';

class CustomButtonDropDown extends StatelessWidget {
  CustomButtonDropDown(
      {super.key,
      required this.preImage,
      required this.text,
      required this.suffixImage});
  String preImage;
  String text;
  String suffixImage;

  @override
  Widget build(BuildContext context) {
    return Container(
  height: 33,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: secondColor7),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Image.asset("assets/icons/" + preImage, width: 15, height: 15,),
          SizedBox(width: 6,),
          BlockCustomText(
            text: text,
            size: 12,
            color: secondColor75,
            weight: FontWeight.bold,
          ),
           SizedBox(width: 6,),
          Image.asset("assets/icons/" + suffixImage,  width: 15, height: 15,),
        ],
      ),
    );
  }
}
