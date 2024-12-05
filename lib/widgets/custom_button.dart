import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onpressed});
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: ElevatedButton.icon(
          onPressed: onpressed,
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              minimumSize: Size(100.w, 40.h),
              backgroundColor: Colors.blue),
          label: Text(
            "UPDATE",
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          )),
    );
  }
}
