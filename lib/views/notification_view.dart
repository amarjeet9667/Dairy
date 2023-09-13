import 'package:diary/controllers/notification_controller.dart';
import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends StatefulWidget {
  final String? message;

  const NotificationView({Key? key, required this.message}) : super(key: key);

  @override
  NotificationViewState createState() => NotificationViewState();
}

class NotificationViewState extends State<NotificationView> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void dispose() {
    controller.decrementNotificationCount();
    controller.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: const Text(
          "Notification",
          style: TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: white),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isPushNotification.value
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          controller.title.value,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => SizedBox(
                          height: Get.height * 0.5,
                          child: Text(
                            controller.body.value,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(() => Text(controller.type.value)),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  'Notification Message For Product: \n ${widget.message}',
                ),
              ),
      ),
    );
  }
}
