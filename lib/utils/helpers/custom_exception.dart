
import 'package:abgtools/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NotifyException implements Exception {
  String? cause;
  bool isCanceled = false;
  NotifyException(this.cause);

  errorMessage() async {
    Get.defaultDialog(
        title: 'excuseme'.tr,
        // onConfirm: () {
        //   isCanceled = true;
        //   Get.back();
        // },
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        confirm: TextButton(
          onPressed: () {
            isCanceled = true;
            Get.back();
          },
          child: Text(
            'ok'.tr,
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(getPrimarColors),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6))),
              padding:  MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15))
                 ),
        ),
        cancelTextColor: Colors.black,
        buttonColor: primaryColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 10, left: 20, right: 20),
              child: Text(
                cause!,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        radius: 3.0);

    await Future.delayed(const Duration(seconds: 5), () async {
      if (!isCanceled) {
        Get.back();
      }
    });
  }

  snackbar() {
    Get.snackbar(
      "",
      cause.toString(),
      colorText: Colors.white,
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      maxWidth: 500,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
