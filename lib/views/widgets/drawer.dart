import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isLogOut = false;
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: white,
        border: Border.all(
          color: green,
        ),
      ),
      child: Drawer(
        elevation: 0,
        backgroundColor: green.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: green,
                ),
              );
            }
            final user = snapshot.data;
            return Column(
              children: [
                DrawerHeader(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "Hi\n${user!.get('name') ?? 'Users'}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                      InkWell(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: white,
                          backgroundImage: user != null
                              ? NetworkImage(user.get('photo') ?? '')
                                  as ImageProvider
                              : const AssetImage('assets/user.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                isLogOut
                    ? const Center(
                        child: CircularProgressIndicator(color: green),
                      )
                    : TextButton(
                        onPressed: () {
                          logOut();
                        },
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                            color: green.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  void logOut() async {
    await firebaseAuth.signOut();
    loginPage();
  }

  void loginPage() {
    Get.offAll(const LoginView());
  }
}
