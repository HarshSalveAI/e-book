import 'package:e_book/Config/Messages.dart';
import 'package:e_book/Pages/Homepage/HomePage.dart';
import 'package:e_book/Pages/WelcomePage/WelcomePage.dart';
import 'package:e_book/admin/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void loginWithEmail() async {
    isLoading.value = true;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        // Extract user details
        final user = userCredential.user!;
        final displayName = user.displayName ?? '';
        final email = user.email ?? '';

        // Store user details in Firestore
        await firestore.collection('users').doc(user.uid).set({
          'displayName': displayName,
          'email': email,
          // You can add more user details here as needed
        });

        if (email == 'qwertymicro8@gmail.com') {
          // Redirect to admin page
          Get.offAll(AdminPage());
        } else {
          // Redirect to home page
          Get.offAll(HomePage());
        }
        successMessage('Login Success');
      } else {
        errorMessage("Error ! Try Again");
      }
    } catch (ex) {
      print(ex);
      errorMessage("Error ! Try Again");
    }
    isLoading.value = false;
  }

  void signout() async {
    await auth.signOut();
    successMessage('Logout');
    Get.offAll(WelcomePage());
  }
}
