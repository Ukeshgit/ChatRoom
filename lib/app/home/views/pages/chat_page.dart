import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/const/apis.dart';
import 'package:chatapp/widgets/chat_user_card.dart';
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
  List<UserModel> list = [];
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Apis.getAllData(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final allData = snapshot.data!.docs;
                      if (allData.isNotEmpty) {
                        final users = allData
                            .map((e) => UserModel.fromFirestore(e.data()))
                            .toList();
                        return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return Text("data");
                          },
                        );
                      } else {
                        return Center(child: Text("OOPS!!! No data found"));
                      }
                  }
                },
              ),
            ),
            _chatInput()
          ],
        ),
      ),
    ));
  }
}

Widget _chatInput() {
  return Row(
    children: [
      Expanded(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                //emoji icon
                Icon(
                  Icons.emoji_emotions,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Type Something...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.blue),
                  ),
                )),

                //gallery icon
                Icon(
                  Icons.image,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 12.w,
                ),
                //camera icon
                Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
      //send icon
      Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 35, // Set a fixed width for the card
          height: 35, // Set a fixed height for the card
          alignment: Alignment.center,
          child: MaterialButton(
            minWidth: 40, // Adjust button width
            height: 40, // Adjust button height
            shape: CircleBorder(),
            color: Colors.green,
            elevation: 1,
            onPressed: () {},
            padding: EdgeInsets.symmetric(
                horizontal: 8), // Add padding for a larger touch area
            child: Icon(
              Icons.send,
              color: Colors.white,
              size: 24, // Increase icon size for better visibility
            ),
          ),
        ),
      )
    ],
  );
}
