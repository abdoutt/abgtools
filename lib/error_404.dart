
import 'package:abgtools/constant.dart';
import 'package:abgtools/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
          color: secondColor3,
            ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/404.svg",
              width: MediaQuery.of(context).size.width,
              ),
              Container(
              
                child: CustomText(
                  text: Get.arguments ?? "404".tr,
                  size: 13,
                  color: Colors.grey,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                 // Get.offAllNamed(loginViewRoute);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: secondColor),
                    borderRadius: BorderRadius.circular(7),
                    color: secondColor,
                  ),
                  child: CustomText(
                    text: "GoBek".tr,
                    size: 13,
                    color: Colors.white,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
