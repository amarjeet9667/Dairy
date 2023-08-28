import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diary/controllers/splash_screen_controller.dart';
import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController controller = Get.put(SplashScreenController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        toolbarHeight: 200,
        title: const Text(
          'Diary',
          style: TextStyle(
            color: white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(
            bottom: Radius.elliptical(190, 150),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
              image: AssetImage('assets/notes.png'),
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Keep your notes safe here',
              style: TextStyle(
                decoration: TextDecoration.none,
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Note Important Things...',
                    textStyle: const TextStyle(
                        color: blue, fontSize: 22, fontWeight: FontWeight.w600),
                    speed: const Duration(microseconds: 99000),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
