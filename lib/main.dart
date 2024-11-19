import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/app/home/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 815),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        // theme: lightTheme,
        // darkTheme: darkTheme,
        // themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: child,
        // initialRoute: '/',
        // getPages: allpages,
      ),
      child: LoginPage(),
    );
  }
}
