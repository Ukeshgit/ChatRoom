import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showbottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Make the background transparent

    builder: (_) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              "Pick Profile Picture",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(eccentricity: 0.6),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Image.asset(
                      "assets/images/add_image.png",
                      height: 100.h,
                      width: 100.w,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(eccentricity: 0.6),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Image.asset(
                      "assets/images/camera.png",
                      height: 100.h,
                      width: 100.w,
                    )),
              ],
            )
          ],
        ),
      );
    },
  );
}
