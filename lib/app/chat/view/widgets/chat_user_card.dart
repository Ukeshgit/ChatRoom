import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/chat/model/chat_model.dart';
import 'package:chatapp/app/chat/view/pages/chat_page.dart';
import 'package:chatapp/const/apis.dart';
import 'package:chatapp/helper/my_date_util.dart';
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
  ChatModel? messages;
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
          child: StreamBuilder(
            stream: Apis.getLastMessages(widget.user),
            builder: (context, snapshot) {
              final alldata = snapshot.data!.docs;
              if (alldata.first.exists) {
                messages = ChatModel.fromJson(alldata.first.data());
              }
              return ListTile(
                  //title
                  title: Text(
                    widget.user.name!,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  //subtitle
                  subtitle: messages != null
                      ? Text(
                          messages!.msg!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.sp),
                        )
                      : Text(
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
                  trailing: messages == null
                      ? SizedBox()
                      : messages!.read!.isEmpty &&
                              messages!.fromId != Apis.user.uid
                          ? Container(
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.greenAccent.shade400),
                            )
                          : Text(
                              MyDateUtil.getLastMessagesTime(
                                  context: context, time: messages!.sent!),
                              style: TextStyle(
                                  fontSize: 16.sp, color: Colors.black45),
                            ));
            },
          )),
    );
  }
}
