import 'package:diary/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  final String? message;

  const ProductPage({Key? key, required this.message}) : super(key: key);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  final HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
      ),
      body: Obx(
        () => Center(
          child: controller.isPushNotification.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(controller.title.value)),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() => Text(controller.body.value)),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(() => Text(controller.type.value)),
                  ],
                )
              : Text(
                  'Notification Message For Product: \n ${widget.message}',
                ),
        ),
      ),
    );
  }
}
