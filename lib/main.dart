import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/app/home/views/pages/home_page.dart';
import 'package:chatapp/app/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//changing the color of status bar
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.teal));
//for setting orientation for potrait only
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDGcgSCk70VtXdu4ml5qcKhbU6hTqSNhrA",
            appId: "1:1039950335044:android:5497d292a310e13d534011",
            messagingSenderId: "1039950335044",
            projectId: "wechat-a3953"));
    runApp(const MyApp());
  });
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
      child: SplashScreen(),
    );
  }
}
