import 'package:diary/helper/constants.dart';
import 'package:diary/views/home_view.dart';
import 'package:diary/views/login_view.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final user = firebaseAuth.currentUser?.obs;
  @override
  void onReady() {
    super.onReady();
    splashControl();
  }

  splashControl() async {
    await Future.delayed(const Duration(seconds: 5));
    user != null ? Get.offAll(const HomeView()) : Get.offAll(const LoginView());
  }
}
