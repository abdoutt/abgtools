

import 'package:abgtools/utils/service/auth_service.dart';
import 'package:get/get.dart';

Future<void> initialConfig() async {
  await Get.putAsync(() => AuthService().init());
  // DBService, ...
}
