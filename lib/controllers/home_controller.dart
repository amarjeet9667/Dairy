import 'package:diary/helper/local_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var title = "".obs;
  var body = "".obs;
  var type = "".obs;
  RxBool isPushNotification = false.obs;

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
      }
    });

    // Foreground State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from foreground state";
      isPushNotification.value = true;
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      title.value = "${event.notification!.title}";
      body.value = "${event.notification!.body}";
      type.value = "I am coming from background state";
      isPushNotification.value = true;
    });
  }

  // //Notification Sending Side Using Dio flutter Library to make http post request

  // Future<void> sendNotification(token, title, body) async {
  //   var postUrl = "https://fcm.googleapis.com/fcm/send";
  //   final data = {
  //     "notification": {"body": "$body", "title": "$title"},
  //     "priority": "high",
  //     "data": {
  //       "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //       "id": "1",
  //       "status": "done"
  //     },
  //     "to": "$token"
  //   };

  //   final headers = {
  //     'content-type': 'application/json',
  //     'Authorization':
  //         'cZ-vUrPBRH6xkR765MEEYB:APA91bHDp00ryZpGywXIXVkM9S0Y2oyn5SKNtYVfB2qpCzbeQivmKuDVQ4xA8w-D9nMAcNu2GTd7Kkcn2TS6iPa43RoMahwK9CH3aXO5L6jzHFGQnE1YnniCH1mwuNVkfD0F-eqcYSto'
  //   };

  //   BaseOptions options = BaseOptions(
  //     connectTimeout: const Duration(microseconds: 5000),
  //     receiveTimeout: const Duration(microseconds: 3000),
  //     headers: headers,
  //   );

  //   try {
  //     final response = await Dio(options).post(postUrl, data: data);

  //     if (response.statusCode == 200) {
  //       Fluttertoast.showToast(msg: 'Request Sent To Driver');
  //     } else {
  //       log('notification sending failed');
  //       // on failure do sth
  //     }
  //   } catch (e) {
  //     log('exception $e');
  //   }
  // }
}
