import 'package:chatapp/app/authentication/model/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Apis {
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
}
