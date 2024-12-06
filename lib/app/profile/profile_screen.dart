import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/authentication/views/login_page.dart';
import 'package:chatapp/const/apis.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.user, this.prefix});
  final UserModel user;
  final dynamic prefix;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Text(
            "Profile Screen",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(children: [])),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User image
                Center(
                    child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80.r,
                      backgroundImage: NetworkImage(widget.user.image!),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 20,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.sp),
                        onTap: () {
                          // Add edit functionality here
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                SizedBox(height: 12.h),

                // User email
                Text(
                  widget.user.email!,
                  style: TextStyle(color: Colors.black54, fontSize: 16.sp),
                ),
                SizedBox(height: 12.h),

                // Name TextField
                CustomTextInputField(
                  initialValue: widget.user.name!,
                  onsaved: (newValue) {
                    Apis.me.name = newValue ?? "";
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Fill Required Field";
                    }
                    return null;
                  },
                  label: "Name",
                  hintText: "e.g Yukesh Katuwal",
                  prefix: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(height: 12.h),

                // About TextField
                CustomTextInputField(
                  initialValue: widget.user.about!,
                  onsaved: (newValue) {
                    Apis.me.about = newValue;
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Fill Required Field";
                    }
                    return null;
                  },
                  label: "About",
                  hintText: "e.g Welcome to we chat",
                  prefix: Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 36.h),

                // Update button
                CustomButton(
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print("Validated");
                      print("Name: ${Apis.me.name}");
                      print("About: ${Apis.me.about}");
                      Apis.updateUserInfo();
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Logout",
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
          shape: const StadiumBorder(),
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            try {
              await Apis.auth.signOut();
              await GoogleSignIn().signOut();
              Get.offAll(() => const LoginPage());
            } catch (e) {
              print(e);
            }
          },
          icon: Icon(
            Icons.logout,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
