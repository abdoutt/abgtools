import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom(
      {super.key,
      required this.iconName,
      required this.mainColors,
      required this.hoverColors,
      required this.activeColors,
      required this.raduiseButton,
      required this.width,
      required this.height,
      required this.onPressed});
  final String iconName;
  final Color mainColors;
  final Color hoverColors;
  final double raduiseButton;
  final Color activeColors;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Theme(
           data: ThemeData(
                                       fontFamily: 'fontfamilly'.tr,            useMaterial3: true),
        child: IconButton(
            icon: Image.asset("assets/icons/" + iconName, width: 18, height: 18),
            onPressed: onPressed,
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(raduiseButton)),
              backgroundColor: mainColors,
              hoverColor: hoverColors,
              focusColor: activeColors,
              disabledForegroundColor: hoverColors,
              foregroundColor: hoverColors,
              highlightColor: mainColors,
            )),
      ),
    );
  }
}
