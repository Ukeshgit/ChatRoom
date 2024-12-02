import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {},
        child: ListTile(
          title: Text(
            "Yukesh Katuwal",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          subtitle: Text(
            "Hello Ram, How are you doing my boy",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp),
          ),
          leading: Icon(
            CupertinoIcons.person,
            size: 24.sp,
          ),
          trailing: Text(
            "12:00 PM",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
