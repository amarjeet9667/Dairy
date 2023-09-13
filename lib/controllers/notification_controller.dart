import 'package:diary/helper/local_notification.dart';
import 'package:diary/views/notification_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  var title = "".obs;
  var body = "".obs;
  var type = "".obs;
  RxBool isPushNotification = false.obs;
  RxInt notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();

    LocalNotificationService.initializer();

    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        title.value = "${event.notification!.title}";
        body.value = "${event.notification!.body}";
        type.value = "I am coming from terminated state";
        isPushNotification.value = true;
        incrementNotificationCount(); // Increment notification count
        Get.to(NotificationView(message: body.value));
      }
    });

    // Foreground State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from foreground state";
      isPushNotification.value = true;
      incrementNotificationCount(); // Increment notification count
    });

    // Background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from background state";
      isPushNotification.value = true;
      incrementNotificationCount(); // Increment notification count
      Get.to(NotificationView(message: body.value));
    });
  }

  // Function to increment the notification count
  void incrementNotificationCount() {
    notificationCount.value++;
    FlutterAppBadger.updateBadgeCount(notificationCount.value);
  }

  void decrementNotificationCount() {
    if (notificationCount.value > 0) {
      notificationCount.value--;
      FlutterAppBadger.updateBadgeCount(notificationCount.value);
    }
  }

  // Function to clear data in the controller
  void clearData() {
    title.value = "";
    body.value = "";
    type.value = "";
    isPushNotification.value = false;
    // You can reset other properties as needed.
  }
}
