import 'package:abgtools/utils/helpers/reponsiveness.dart';
import 'package:abgtools/viewmodel/loginViewModel.dart';
import 'package:abgtools/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constant.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginViewModel vm = Get.put(LoginViewModel());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: 600),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: ResponsiveWidget.isSmallScreen(context) ? 300 : 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Image.asset("assets/images/logo-with-shaow.png",),
                        const SizedBox(
                          height: 10,
                        ),
                      
                      ],
                    ),
                  ),
                  ResponsiveWidget.isSmallScreen(context)
                      ? const Expanded(child: SizedBox())
                      : const SizedBox(
                          height: 20,
                        ),
                  Center(
                    child: Form(
                      key: vm.key,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: const[
                              Padding(
                                padding:  EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: CustomText(
                                  text: "البريد الالكتروني",
                                  size: 13,
                                weight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          TextFormField(
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              errorStyle: TextStyle(
                                fontSize: 0.1,
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 12.0),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: secondColor25,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:  BorderSide(
                                  color: secondColor75,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: secondColor25,
                                    width: 2.0,
                                  )),
                            ),
                            controller: vm.fullNameControler,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 13),
                            autocorrect: false,
                            onFieldSubmitted: (_) {
                              vm.validateFormAndLogin(context);
                            },
                            validator: (val) => validateEmail(val!),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const[
                              Padding(
                                padding:  EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: CustomText(
                                  text: "كلمة المرور",
                                  size: 13,
                                  weight: FontWeight.w600,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Obx(() => TextFormField(
                                decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontSize: 0.1,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: secondColor25,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      borderSide:  BorderSide(
                                        color: secondColor75,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: secondColor25,
                                          width: 2.0,
                                        )),
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        hoverColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        splashColor: const Color.fromARGB(
                                            0, 255, 255, 255),
                                        icon: vm.obscurePassword.value
                                            ?  Icon(
                                                Icons.visibility_off_outlined, color: secondColor75,)
                                            :  Icon(
                                                Icons.visibility_outlined, color: secondColor75,),
                                        onPressed: () {
                                          vm.toglePassword(
                                              vm.obscurePassword.value);
                                        },
                                      ),
                                    )),
                                obscureText: vm.obscurePassword.value,
                                controller: vm.passwordController,
                                style: TextStyle(fontSize: 13),
                                onFieldSubmitted: (_) {
                                  vm.validateFormAndLogin(context);
                                },
                                validator: (val) => validateRequired(
                                    val!, 'كلمة المرور'),
                              )),
                          Obx(() => vm.loginvalidation.value
                              ? const SizedBox()
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                     SizedBox(
                                      height: 20,
                                    ),
                                    CustomText(
                                        text: 'اسم المستخدم أو كلمة المرور غير صحيحة',
                                        size: 13,
                                        color: Colors.red,
                                        aligment: TextAlign.left),
                                  ],
                                )),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  vm.validateFormAndLogin(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Obx(() => vm.loading.value
                                          ? const SpinKitCircle(
                                              color: Colors.amber,
                                              size: 20.0,
                                            )
                                          : const SizedBox()),
                                      const CustomText(
                                        text: "تسجيل الدخول",
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveWidget.isSmallScreen(context)
                      ? const Expanded(child: const SizedBox())
                      : const SizedBox(),
                  ResponsiveWidget.isSmallScreen(context)
                      ? CustomText(
                          text: "مدعوم من Gamedev",
                          size: 14,
                          color: Colors.black,
                          weight: FontWeight.w400,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
