import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class Apis {
  //for storing late info
  static late UserModel me;
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accesing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //to return current user
  static User get user => auth.currentUser!;

  //for checking if user exists or not ?
  static Future<bool> userExists() async {
    return (await firestore.collection('user').doc(user.uid).get()).exists;
  }

  //update user information
  static Future<void> updateUserInfo() async {
    (await firestore
        .collection('user')
        .doc(user.uid)
        .set({'name': me.name, 'about': me.about}));
  }

  //for checking if user exists or not ?
  static Future<void> getSelfUserInfo() async {
    await firestore.collection('user').doc(user.uid).get().then((user) {
      if (user.exists) {
        me = UserModel.fromFirestore(user.data()!);
      } else {
        createUser().then((value) => getSelfUserInfo());
      }
    });
  }

//for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now();
    final chatUser = UserModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        image: user.photoURL.toString(),
        about: "Hey , I'm using We Chat!",
        isOnline: false,
        createdAt: time,
        pushTokens: '',
        lastActive: time);
    return (await firestore
        .collection('user')
        .doc(user.uid)
        .set(chatUser.toFirestore()));
  }

  //load data from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllData() {
    return firestore
        .collection('user')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  //to get messages from specific user from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatMessages() {
    return firestore
        .collection('messages')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
