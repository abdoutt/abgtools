import 'package:abgtools/constant.dart';
import 'package:abgtools/error_404.dart';
import 'package:abgtools/setting/initial_config.dart';
import 'package:abgtools/utils/middleware/authmiddleware.dart';
import 'package:abgtools/utils/middleware/dashboord_middleware.dart';
import 'package:abgtools/utils/routing.dart';
import 'package:abgtools/view/LoginView.dart';
import 'package:abgtools/view/home.dart';
import 'package:abgtools/widgets/customTransitionBuilder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await initialConfig();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return    GetMaterialApp(
      initialRoute: loginViewRoute,
       initialBinding: Init(),
      unknownRoute:
          GetPage(name: PageNotFoundRoute, page: () => PageNotFound()),

      getPages: [
        GetPage(
            name: rootRoute,
            page: () => HomeView(),
          middlewares: [DashboordMiddleware()] ),// middlewares: [DashboordMiddleware()]
         GetPage(name: loginViewRoute, page: () => const LoginView(), middlewares: [AuthMiddleware()]),//middlewares: [AuthMiddleware()]
      ],

      debugShowCheckedModeBanner: false,
      title: 'ABG Tools',
      theme: ThemeData(
        fontFamily: 'NotoKufiArabic',
        primaryColor: primaryColor,
           checkboxTheme: CheckboxThemeData(
          side: MaterialStateBorderSide.resolveWith(
              (_) => BorderSide(width: 1, color: secondColor)),
          fillColor: MaterialStateProperty.all(secondColor),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.windows: CustomTransitionBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      // home: AuthenticationPage(),
    );
  
  }
}

