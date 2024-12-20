import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/chat/model/chat_model.dart';
import 'package:chatapp/app/chat/view/widgets/message_card.dart';
import 'package:chatapp/const/apis.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

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
  bool showemoji = false;
  //for storing list message
  List<ChatModel> list = [];
  TextEditingController _textcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the status bar color when the page is initialized
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
//for handling message text
    // Ensure this is in the build method, so it applies whenever the widget rebuilds
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
      ),
    );
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (showemoji) {
            setState(() {
              showemoji = !showemoji;
            });
            //screen is not removed
            return Future.value(false);
          }
          //screen is removed
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  child: StreamBuilder(
                    stream: Apis.getUserInfo(widget.user),
                    builder: (context, snapshot) {
                      final alldata = snapshot.data!.docs,
                          listOfGetUser = alldata
                              .map((e) => UserModel.fromjson(e.data()))
                              .toList();
                      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
                      print(listOfGetUser);

                      return Row(
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                //subtitle->shows the last seen time of user
                                Text(
                                  listOfGetUser.isEmpty
                                      ? listOfGetUser[0].isOnline!
                                          ? "Online"
                                          : listOfGetUser[0]
                                              .lastActive!
                                              .toString()
                                      : widget.user.lastActive.toString(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ))),
          body: Container(
            color: const Color.fromARGB(255, 234, 238, 255),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: Apis.getAllChatMessages(widget.user),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Center(child: SizedBox());
                          case ConnectionState.active:
                          case ConnectionState.done:
                            final allData = snapshot.data!.docs;
                            print("DDDDDDDDDDDDDDDDDDDDDEEEEEEEEEEEEEEEEEEEEE");
                            print(allData);

                            if (allData.isNotEmpty) {
                              list = allData
                                  .map((e) => ChatModel.fromJson(e.data()))
                                  .toList();

                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return MessageCard(messages: list[index]);
                                },
                              );
                            } else {
                              return Center(
                                  child: Text(
                                "Say Hi!👋",
                                style: TextStyle(fontSize: 20.sp),
                              ));
                            }
                        }
                      },
                    ),
                  ),
                  _chatInput(),
                  if (showemoji)
                    EmojiPicker(
                        textEditingController:
                            _textcontroller, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                        config: Config(
                          bottomActionBarConfig:
                              BottomActionBarConfig(enabled: false),
                          customBackspaceIcon: Icon(Icons.safety_check),
                          searchViewConfig: SearchViewConfig(),
                          height: 276.h,
                        )),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        showemoji = !showemoji;
                      });
                    },
                    child: Icon(
                      Icons.emoji_emotions,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                      child: TextField(
                    onTap: () {
                      if (showemoji) {
                        showemoji = !showemoji;
                      }
                    },
                    controller: _textcontroller,
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

        Bounce(
          child: IconButton(
            onPressed: () {
              if (_textcontroller.text.toString().isNotEmpty) {
                Apis.sendMessage(widget.user, _textcontroller.text.toString());
              }
              _textcontroller.text = "";
            },
            icon: Icon(Icons.send),
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
