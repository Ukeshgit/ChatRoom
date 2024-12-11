import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/app/chat/model/chat_model.dart';
import 'package:chatapp/const/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.messages});
  final ChatModel messages;

  @override
  Widget build(BuildContext context) {
    return Apis.user.uid == messages.fromId ? _greenMessage() : _blueMessage();
  }

  //sender or another user message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 221, 245, 255),
                border: Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.sp),
                    topRight: Radius.circular(12.sp),
                    bottomRight: Radius.circular(12.sp))),
            margin: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 4.w),
            child: Text(
              messages.msg!,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Text(
            messages.read! + "12:00 PM",
            style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
          ),
        )
      ],
    );
  }

  //our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Icon(
                  Icons.done_all,
                  color: Colors.blueAccent,
                )),
            SizedBox(
              width: 6.w,
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Text(
                messages.read! + "11:58 PM",
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 218, 255, 176),
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.sp),
                    topRight: Radius.circular(12.sp),
                    bottomRight: Radius.circular(12.sp))),
            margin: EdgeInsets.symmetric(horizontal: 8.h, vertical: 8.w),
            padding: EdgeInsets.symmetric(horizontal: 6.h, vertical: 4.w),
            child: Text(
              messages.msg!,
              style: TextStyle(color: Colors.black, fontSize: 22.sp),
            ),
          ),
        ),
      ],
    );
    ;
  }
}
