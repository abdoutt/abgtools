import 'dart:convert';
import 'package:abgtools/model/envrinementModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

FlutterSecureStorage  storage = new FlutterSecureStorage();
Future<EnvrinementModel?> getEnvirenment() async {
  String? envirenmentMap = await storage.read(key: "Envirenment");
  if ((envirenmentMap ?? '') == '' || envirenmentMap == 'null') {
    return null;
  } else {
    var envirenment = EnvrinementModel.fromMap(json.decode(envirenmentMap!));
    return envirenment;
  }
}

setEnvirenment(EnvrinementModel? envirenment) async {
  if (envirenment == null) {
    //await setPreferenceString("Envirenment", '');
    await storage.write(key: "Envirenment", value: "");
  } else {
    await storage.write(
        key: "Envirenment", value: json.encode(envirenment.toMap()));

    //await setPreferenceString("Envirenment", json.encode(envirenment.toMap()));
  }
}

clearEnvirenment() async {
  await storage.delete(key: 'Envirenment');
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  Get.delete();
  //prefs.clear();
}
