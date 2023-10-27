import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isAds = false.obs;

  void adsSection() async {
    try {
      

    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
