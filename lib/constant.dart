import 'package:abgtools/utils/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
const uri = '192.168.1.15:8888';
//const uri = 'tools.abgservice.net';
final authService = Get.find<AuthService>();
Color primaryColor = const Color(0xFFF89721);
Color primaryColor10 = const Color(0xFFF89721).withOpacity(0.1);
const secondColor = Color(0xFF212121);
Color secondColor75 = const Color(0xFF212121).withOpacity(0.75);
Color secondColor50 = const Color(0xFF212121).withOpacity(0.5);
Color secondColor25 = const Color(0xFF212121).withOpacity(0.25);
Color secondColor20 = const Color(0xFF212121).withOpacity(0.20);
Color secondColor7 = const Color(0xFF212121).withOpacity(0.07);
Color secondColor3 = const Color(0xFF212121).withOpacity(0.03);



Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.transparent;
  }
  return Colors.transparent;
}

Color getPrimerEffect(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered
  };
  if (states.any(interactiveStates.contains)) {
    return primaryColor10;
  }
  return Colors.transparent;
}

Color getSecondColors(Set<MaterialState> states) {
  const Set<MaterialState> hovered = <MaterialState>{MaterialState.hovered};
  const Set<MaterialState> pressed = <MaterialState>{MaterialState.pressed};
  if (states.any(hovered.contains)) {
    return secondColor20;
  }
  if (states.any(pressed.contains)) {
    return secondColor50;
  }
  return Colors.transparent;
}

Color getPrimarColors(Set<MaterialState> states) {
  const Set<MaterialState> hovered = <MaterialState>{MaterialState.hovered};
  const Set<MaterialState> pressed = <MaterialState>{MaterialState.pressed};
  if (states.any(hovered.contains)) {
    return primaryColor;
  }
  if (states.any(pressed.contains)) {
    return primaryColor;
  }
  return Colors.transparent;
}

Color getColorGreen(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered
  };
  if (states.any(interactiveStates.contains)) {
    return const Color(0xff0f4934);
  }
  return Colors.transparent;
}

Color getColorGreay(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered
  };
  if (states.any(interactiveStates.contains)) {
    return secondColor7;
  }
  return secondColor3;
}
final DateFormat formatter = DateFormat('yyyy-MM-dd');

String? validateEmail(String value) {
  if (value == null || value == '') {
    return 'ُEmail Required field';
  }
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value)) {
    return 'Entre best format';
  }
  return null;
}



String? validateRequired(String val, fieldName) {
  if (val == null || val == '') {
    return fieldName + ' ' + 'Required field';
  }
  return null;
}

Init(){
  Get.updateLocale(Locale("ar"));
}




final cardTitleTextStyle =
    TextStyle(fontSize: 13, color: secondColor, fontWeight: FontWeight.bold);
final cardSubTitleTextStyle =
    TextStyle(fontSize: 11, color: secondColor50, fontWeight: FontWeight.bold);
final cardResultTextStyle = TextStyle(fontSize: 11, color: secondColor75);
final cardFieldPadding =
    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.50);


    final columnTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: secondColor75,
   fontFamily: 'NotoKufiArabic',
);

final rowTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: secondColor,
   fontFamily: 'NotoKufiArabic',
);