import 'package:abgtools/utils/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//const uri = '192.168.1.13:8888';
const uri = 'api.aj-abg.com';
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
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final formatCurrency =
    new NumberFormat.simpleCurrency(locale: "Ar", decimalDigits: 3, name: "");
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

Init() {
  Get.updateLocale(Locale("fr"));
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

final popUpNoteMessageTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Colors.red,
  fontFamily: 'fontfamilly'.tr,
);

final rowTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: secondColor,
  fontFamily: 'NotoKufiArabic',
);

final popUpTitleMessageTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: secondColor75,
  fontFamily: 'fontfamilly'.tr,
);

final popUpContentMessageTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontFamily: 'fontfamilly'.tr,
);
final popUpMaxWidth = 400.0;
sheetRequiredCheckerMessage({
  required String sheetName,
}) =>
    Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        content: Container(
            constraints: BoxConstraints(maxWidth: popUpMaxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "خطأ في التحقق من صحة الورقة",
                          style: popUpTitleMessageTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'الورقة المحددة "$sheetName" لم يتم العثور عليها في الملف الذي تم تحميله. الرجاء التحقق مرة أخرى من اسم الورقة وحاول مجددا.',
                        style: popUpContentMessageTextStyle,
                      ),
                    )
                  ],
                ),
              ],
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    //call back
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)))),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "اوكي",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ],
        radius: 3.0);

columnRequiredCheckerMessage(
        {required String columnName, required int columnIndex}) =>
    Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        content: Container(
          constraints: BoxConstraints(maxWidth: popUpMaxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Erreur de validation de fichier",
                        style: popUpTitleMessageTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Désolé, nous ne pouvons pas traiter ce fichier car il manque une colonne "$columnName" Veuillez vérifier que votre fichier inclut cette colonne et réessayer',
                      overflow: TextOverflow.visible,
                      style: popUpContentMessageTextStyle,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Remarque : la colonne doit être dans l'index $columnIndex",
                      style: popUpNoteMessageTextStyle,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        //call back
                        Get.back();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(primaryColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OK",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
        radius: 3.0);

rowRequiredCheckerMessage({
  required String columnName,
  required int rowIndex,
}) =>
    Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        content: Container(
            constraints: BoxConstraints(maxWidth: popUpMaxWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "Erreur de validation de fichier",
                          style: popUpTitleMessageTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Désolé, nous ne pouvons pas traiter votre fichier car le numéro de ligne "$rowIndex" il manque des données obligatoires dans la colonne "$columnName".',
                        style: popUpContentMessageTextStyle,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Veuillez vérifier que votre fichier contient des données valides dans cette colonne pour toutes les lignes et réessayez',
                        style: popUpContentMessageTextStyle,
                      ),
                    )
                  ],
                ),
              ],
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    //call back
                    Get.back();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(primaryColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)))),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "OK",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ],
        radius: 3.0);

String? validateDate(String value) {
  if (value == null || value == '') {
    return 'email_validation'.tr;
  }
  var pattern =
      r'^([0]?[1-9]|[1|2][0-9]|[3][0|1])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$';
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value)) {
    return 'emailregex'.tr;
  }
  return null;
}
