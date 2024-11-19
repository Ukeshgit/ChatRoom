import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: Icon(
            CupertinoIcons.home,
            size: 24.sp,
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "We chat",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.blueAccent,
          onPressed: () {},
          child: Icon(
            Icons.chat,
            color: Colors.white,
          ),
        ));
  }
}
