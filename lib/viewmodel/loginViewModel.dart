import 'dart:async';

import 'package:abgtools/constant.dart';
import 'package:abgtools/setting/storage_cache.dart';
import 'package:abgtools/utils/helpers/custom_exception.dart';
import 'package:abgtools/utils/service/login_api.dart';
import 'package:abgtools/view/home.dart';
import 'package:abgtools/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import '../utils/routing.dart';

class LoginViewModel extends GetxController {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  RxBool obscurePassword = true.obs;
  RxBool loginvalidation = true.obs;
  RxBool loading = false.obs;
  late TextEditingController fullNameControler;
  late TextEditingController passwordController;
  @override
  void onInit() {
    super.onInit();
    obscurePassword.value = true;
    loginvalidation.value = true;
    loading.value = false;
    fullNameControler = TextEditingController();
    passwordController = TextEditingController();
  }

  loginValidation(BuildContext context) async {
    showDialog<void>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.9),
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              title: null,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: const [
                      SpinKitCircle(
                        color: Colors.amber,
                        size: 30.0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(text: 'Traitement maintenant')
                    ],
                  )
                ],
              ));
        });

    try {
      loading.value = true;
      var t = await login_api(fullNameControler.text, passwordController.text);
      if (t == null) {
        loginvalidation.value = false;
      } else {
        passwordController.text = "";
        //preparEnvirnement
        loginvalidation.value = true;
        await setEnvirenment(t);
        await authService.init();
        Get.offAllNamed(rootRoute);
      }
    } on NotifyException catch (e) {
      Get.back();
      loginvalidation.value = false;
      return;
    } on UnauthorizedException catch (e) {
      //show notification of session expired
      Get.back();
      loginvalidation.value = false;
    } on TimeoutException catch (e) {
      //show message of time out error to user try again
      Get.back();
    } catch (e) {
      //show globle notification to display error message
      loginvalidation.value = false;
      Get.back();
    } finally {
      loading.value = false;
    }
  }

  void toglePassword(bool passowrd) {
    obscurePassword.value = !passowrd;
  }

  validateFormAndLogin(BuildContext context) {
    // Get form state from the global key
    var formState = key.currentState;

    // check if form is valid
    if (formState!.validate()) {
      loginValidation(context);
    }
  }
}
