import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 45.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Welcome to We chat",
                  style: TextStyle(color: Colors.black, fontSize: 24.sp),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Image.asset(
                "assets/images/chat.png",
                height: 350.h,
                width: 350.w,
              ),
              Spacer(),
              SizedBox(
                height: 55.h,
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    shape: StadiumBorder(),
                    elevation: 1,
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/google_logo.svg",
                    height: 20.h,
                    width: 20.w,
                  ),
                  onPressed: () {
                    // Add your sign-in logic here
                  },
                  label: Text(
                    "Sign In with Google",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
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
