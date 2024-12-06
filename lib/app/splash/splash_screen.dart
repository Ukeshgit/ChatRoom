import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/app/home/views/pages/home_page.dart';
import 'package:chatapp/const/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    // Set system UI mode to show only the bottom navigation bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    // Set the navigation bar color to white
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    // Navigate after 3 seconds based on authentication status
    Future.delayed(Duration(seconds: 3), () {
      if (Apis.auth.currentUser != null) {
        Get.offAll(() => HomeScreen());
      } else {
        Get.offAll(() => LoginPage());
      }
    });
  }

  @override
  void dispose() {
    // Restore the status bar when leaving the screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset(
        "assets/images/appIcon.png",
        height: 100.h,
        width: 100.w,
      )),
    );
  }
}
