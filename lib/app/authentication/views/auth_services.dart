import 'package:chatapp/app/home/views/pages/home_page.dart';
import 'package:chatapp/const/apis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart'; // Ensure Getx is imported for navigation

Future<void> signInWithGoogle() async {
  try {
    // Begin interactive sign-in process
    final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
    if (guser == null) {
      // User canceled the sign-in process
      print("User canceled the sign-in process");
      return;
    }

    // Obtain auth details from the request
    final GoogleSignInAuthentication gauth = await guser.authentication;

    // Create credentials for the user
    final credentials = GoogleAuthProvider.credential(
      accessToken: gauth.accessToken,
      idToken: gauth.idToken,
    );

    // Sign in with Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credentials);

    // Check if sign-in was successful
    if (await Apis.userExists()) {
      // Navigate to the homepage
      Get.to(() => HomeScreen());
    } else {
      Apis.createUser().then((value) {
        print("Successfully signed in: ${userCredential.user!.email}");
        // Navigate to the homepage
        Get.to(() => HomeScreen());
      });
    }
  } catch (e) {
    print("Error signing in with Google: $e");
    Get.snackbar("Sign-In Error", e.toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
}
