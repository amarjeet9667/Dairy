import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLogIn = false.obs;
  final signIn = GoogleSignIn.standard();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  signInWithGoogle() async {
    Get.dialog(
      const AlertDialog(
        backgroundColor: white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: green),
            SizedBox(height: 16),
            Text("Processing........"),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    final account = await signIn.signIn();
    final authentican = await account!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: authentican.accessToken,
      idToken: authentican.idToken,
    );
    try {
      await firebaseAuth.signInWithCredential(credential);
      if (firebaseAuth.currentUser == null) {
        Get.snackbar('Error', 'Unable to logIn');
      } else {
        saveUser(
            name: account.displayName!,
            email: account.email,
            photo: account.photoUrl!,
            login: DateTime.now().toUtc.toString());

        saveUserLogInStatus();
      }
    } on FirebaseException catch (e) {
      Get.snackbar('Error', '${e.message}');
    }
  }

  void saveUser({
    required String name,
    required String email,
    required String photo,
    required String login,
  }) async {
    final uid = firebaseAuth.currentUser!.uid;
    final firebaseFirestore =
        await firestore.collection("Users").where('uid', isEqualTo: uid).get();
    if (firebaseFirestore.docs.isEmpty) {
      await firestore.collection('Users').doc(uid).set({
        'name': name,
        'email': email,
        'photo': photo,
        'login': FieldValue.serverTimestamp(),
      }).then((_) {
        Get.offAll(const HomeView());
      });
    } else {
      Get.offAll(const HomeView());
    }
  }

  checkUserLogInStatus() async {
    SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  saveUserLogInStatus() async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', true);
  }

  removeLogInStatus() async {
    SharedPreferences prefs = await _prefs;
    prefs.remove('isLoggedIn');
  }

  checkUserLogIn() async {
    bool isLoggedIn = await checkUserLogInStatus();
    if (isLoggedIn) {
      Get.offAll(const HomeView());
    }
  }

  userLogout() async {
    await firebaseAuth.signOut();
    removeLogInStatus();
    isLogIn.value = false;
  }
}
