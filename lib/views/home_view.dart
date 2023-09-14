import 'dart:developer';

import 'package:badges/badges.dart' as Badges;
import 'package:diary/controllers/notification_controller.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/model/dairy_details_model.dart';
import 'package:diary/views/dairy_view.dart';
import 'package:diary/views/details.dart';
import 'package:diary/views/notification_list_view.dart';
import 'package:diary/views/notification_view.dart';
import 'package:diary/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diary/controllers/diary_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DiaryController _diaryController = Get.put(DiaryController());
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        height: Get.height,
      ),
      appBar: AppBar(
        backgroundColor: green,
        leading: StreamBuilder(
            stream: firestore
                .collection('Users')
                .doc(firebaseAuth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                const CircularProgressIndicator();
              }
              final user = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: white,
                        backgroundImage: user != null
                            ? NetworkImage(user.get('photo') ?? '')
                                as ImageProvider
                            : const AssetImage('assets/user.png'),
                      ),
                    )
                  ],
                ),
              );
            }),
        title: const Text(
          'Diary Entries',
          style: TextStyle(
            fontSize: 22,
            color: white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          Badges.Badge(
            position: Badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeContent: Obx(
              () => Text(
                '${controller.notificationCount.value}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: white,
              ),
              onPressed: () {
                Get.to(const NotificationListView());
                // Get.to(const NotificationView(message: ''));
                log('InitialValue:-${controller.notificationCount.value}');
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: green,
        onRefresh: () async {
          _diaryController.fetchDiaryEntry();
        },
        child: StreamBuilder<List<DairyEntryModel>>(
          stream: _diaryController.fetchDiaryEntry(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No entries available.'),
              );
            } else {
              List<DairyEntryModel> entries = snapshot.data!;
              return ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  var entry = entries[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Get.to(DetailsView(entry: entry));
                        },
                        title: Text(
                          entry.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          entry.body.split('\n').sublist(0, 1).join('\n'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Get.dialog(AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Are you sure',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text(
                                          'cancel',
                                          style: TextStyle(
                                            color: blue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _diaryController
                                              .deleteEntry(entry.id);
                                          Get.back();
                                        },
                                        child: const Text(
                                          'yes',
                                          style: TextStyle(
                                            color: blue,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ));
                            // _diaryController.deleteEntry(entry.id);
                          },
                          icon: const Icon(Icons.delete, color: grey),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const DairyView());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
