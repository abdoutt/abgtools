import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockCustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final double? height;
  final TextAlign? aligment;
  final FontWeight? weight;

  const BlockCustomText(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.height,
      this.aligment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: aligment,
      
      style: TextStyle(
          fontFamily: 'fontfamilly'.tr,
          height: height ?? 1.5,
          fontSize: size ?? 13,
          color: color ?? Colors.black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
