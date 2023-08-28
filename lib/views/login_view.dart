import 'package:diary/controllers/login_controller.dart';
import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Welcome',
              style: TextStyle(
                color: black,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            const Image(
              image: AssetImage('assets/notes.png'),
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 10),
            const Text(
              'Keep your notes safe here',
              style: TextStyle(
                color: black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                controller.signInWithGoogle();
              },
              child: Container(
                height: 50,
                width: Get.width * 0.8,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25), color: black),
                child: const Row(
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Image(
                        image: AssetImage('assets/google.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Login with google',
                      style:
                          TextStyle(color: white, fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: green,
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
    );
  }

  @override
  Widget get child => Container();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);
}
