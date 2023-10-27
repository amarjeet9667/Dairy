import 'package:diary/controllers/notification_controller.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/views/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.recievedNotification.length,
          itemBuilder: (context, index) {
            final notification = controller.recievedNotification[index];
            return ListTile(
              onTap: () {
                Get.to(
                    NotificationView(message: '', notification: notification));
              },
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(notification.timestamp),
            );
          },
        ),
      ),
    );
  }
}
