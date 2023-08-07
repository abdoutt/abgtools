import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



FlutterSecureStorage  storage = new FlutterSecureStorage();
Future<String?> getEnvirenment() async {
  String? envirenmentMap = await storage.read(key: "Envirenment");
  if ((envirenmentMap ?? '') == '' || envirenmentMap == 'null') {
    return null;
  } else {
    var envirenment = envirenmentMap;
    return envirenment;
  }
}

setEnvirenment(String? envirenment) async {
  if (envirenment == null) {
    //await setPreferenceString("Envirenment", '');
    await storage.write(key: "Envirenment", value: "");
  } else {
    await storage.write(
        key: "Envirenment", value: envirenment);

    //await setPreferenceString("Envirenment", json.encode(envirenment.toMap()));
  }
}

clearEnvirenment() async {
  await storage.delete(key: 'Envirenment');
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.delete();
  //prefs.clear();
}
