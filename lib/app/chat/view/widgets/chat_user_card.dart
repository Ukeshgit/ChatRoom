import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/chat/view/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    print("User image URL: ${widget.user.image}");
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: () {
          Get.to(() => ChatPage(
                user: widget.user,
              ));
        },
        child: ListTile(
            //title
            title: Text(
              widget.user.name!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
            ),
            //subtitle
            subtitle: Text(
              widget.user.about!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp),
            ),
            //leading icon
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                height: 40.h,
                width: 40.w,
                imageUrl: widget.user.image!,
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            trailing: (!widget.user.isOnline!)
                ? Container(
                    height: 15.h,
                    width: 15.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.greenAccent.shade400),
                  )
                : SizedBox()),
      ),
    );
  }
}
