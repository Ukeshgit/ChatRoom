import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {},
        child: ListTile(
          //title
          title: Text(
            user.name!,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          ),
          //subtitle
          subtitle: Text(
            user.about!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14.sp),
          ),
          //leading icon
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
