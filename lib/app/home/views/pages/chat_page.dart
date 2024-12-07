import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Ensure this is in the build method, so it applies whenever the widget rebuilds
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Ensure this is in the build method, so it applies whenever the widget rebuilds
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure this is in the build method, so it applies whenever the widget rebuilds
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ),
    );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back)),
                SizedBox(
                  width: 12.w,
                ),
                //image

                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CachedNetworkImage(
                    height: 40.h,
                    width: 40.w,
                    imageUrl: widget.user.image!,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Column(
                    children: [
                      //title->show name
                      Text(
                        widget.user.name!,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      //subtitle->shows the last seen time of user
                      Text(
                        "Last Seen not Available ",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    ));
  }
}
