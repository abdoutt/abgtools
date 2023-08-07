
import 'package:abgtools/utils/routing.dart';
import 'package:abgtools/utils/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboordMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    if (authService.isLogin.value == false)
      return const RouteSettings(name: loginViewRoute);
  }
}
