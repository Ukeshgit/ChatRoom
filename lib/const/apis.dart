import 'dart:math';

import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:chatapp/app/chat/model/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  static Future<void> getSelfUserInfo() async {
    await firestore.collection('user').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = UserModel.fromjson(user.data()!);
        await getFirebaseMessagingToken(); // Await to ensure token is fetched
        if (me.pushTokens != null) {
          updateActiveStatus(true, me.pushTokens!);
        } else {
          print("Push tokens are still null after fetching.");
        }
      } else {
        await createUser(); // Ensure user is created before retrying
        await getSelfUserInfo();
      }
    }).catchError((e) {
      print("Error in getSelfUserInfo: $e");
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
        .set(chatUser.tojson()));
  }

  //load data from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllData() {
    return firestore
        .collection('user')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
  //chats(collection)-->collection id-->messages(collection)-->message(doc)

  //useful for getting user conversation id
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_${id}'
      : '${id}_${user.uid}';

  //to get messages from specific user from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatMessages(
      UserModel chatuser) {
    return firestore
        .collection('chats/${getConversationId(chatuser.id!)}/messages/')
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(UserModel chatuser, String msg) async {
    //message sending time used as id
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    //message to send
    final ChatModel message = ChatModel(
        toId: chatuser.id,
        msg: msg,
        read: '',
        // type: Type.text,
        fromId: user.uid,
        sent: time);
    final ref = firestore
        .collection('chats/${getConversationId(chatuser.id!)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //update read status of message
  static Future<void> updateMessageReadStatus(ChatModel messages) async {
    firestore
        .collection('chats/${getConversationId(messages.fromId!)}/messages/')
        .doc(messages.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  //to get last message from the specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessages(
      UserModel chatuser) {
    return firestore
        .collection('chats/${getConversationId(chatuser.id!)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //for getting specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      UserModel chatuser) {
    return firestore
        .collection('user')
        .where('id', isEqualTo: chatuser.id)
        .snapshots();
  }

  // For accessing Firebase Messaging (Push notifications)
  static FirebaseMessaging fmessaging = FirebaseMessaging.instance;

// For getting Firebase Messaging token
  static Future<void> getFirebaseMessagingToken() async {
    await fmessaging.requestPermission(); // Request notification permissions
    String? token = await fmessaging.getToken(); // Await the token generation
    if (token != null) {
      me.pushTokens = token; // Assign the token to me.pushTokens
      print("Push Token=$token");
    } else {
      print("Failed to fetch push token.");
    }
  }

  //update online or active status of user
  static Future<void> updateActiveStatus(
      bool isOnline, String pushTokens) async {
    firestore.collection('user').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_tokens': pushTokens
    });
    print(
        "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ");
    print(pushTokens);
  }
}
