
import 'package:abgtools/utils/routing.dart';
import 'package:abgtools/utils/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    print(authService.isLogin.value);
    if (authService.isLogin.value)return const RouteSettings(name: rootRoute);
  }
}
