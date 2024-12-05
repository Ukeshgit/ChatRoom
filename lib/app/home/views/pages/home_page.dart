import 'dart:developer';

import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/app/profile/profile_screen.dart';
import 'package:chatapp/const/apis.dart';
import 'package:chatapp/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Apis.getSelfUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List list = [];
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
                InkWell(
                  onTap: () {
                    Get.to(() => ProfileScreen(user: Apis.me));
                  },
                  child: Icon(
                    Icons.more_vert,
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          try {
            await Apis.auth.signOut();
            await GoogleSignIn().signOut();
            Get.offAll(() => LoginPage());
          } catch (e) {
            print(e);
          }
        },
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: Apis.getAllData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(child: CircularProgressIndicator());

            //some data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:
              final alldata = snapshot.data!.docs;
              list = alldata
                  .map((e) => UserModel.fromFirestore(e.data()))
                  .toList();
          }
          if (list.isNotEmpty) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ChatUserCard(user: list[index]);
              },
            );
          } else {
            return Center(child: Text("OOPS!!!No data found"));
          }
        },
      ),
    );
  }
}
