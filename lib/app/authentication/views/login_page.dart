import 'package:chatapp/app/home/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isAnimate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _isAnimate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        //appbar
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Welcome to We Chat",
            style: TextStyle(color: Colors.black, fontSize: 24.sp),
          ),
        ),
        body: Stack(
          children: [
            // Centered Image
            AnimatedPositioned(
              duration: Duration(microseconds: 1200),
              child: Positioned(
                right: !_isAnimate ? 1.h : width * 0.5,
                child: Column(
                  children: [
                    SizedBox(
                      height: 90.h,
                    ),
                    Image.asset(
                      "assets/images/chat.png",
                      height: 300.h,
                      width: 300.w,
                    ),
                  ],
                ),
              ),
            ),

            // Button at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 90.h),
                child: SizedBox(
                  height: 55.h,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      shape: const StadiumBorder(),
                      elevation: 1,
                    ),
                    icon: SvgPicture.asset(
                      "assets/icons/google_logo.svg",
                      height: 20.h,
                      width: 20.w,
                    ),
                    onPressed: () {
                      Get.offAll(() => const HomeScreen());
                    },
                    label: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Log in with ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          TextSpan(
                            text: "Google",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
