import 'package:diary/helper/common_textfield.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/model/dairy_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  final DairyEntryModel entry;

  const DetailsView({required this.entry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        backgroundColor: green,
        title: const Text(
          'Details of the thoughts',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              height: 100,
              width: Get.width,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: CommonTextField(
                controller: TextEditingController(text: entry.title),
                hintText: 'Title:-',
                maxLines: 5,
                fontSize: 25,
                textSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Divider(),
            Expanded(
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: CommonTextField(
                  controller: TextEditingController(text: entry.body),
                  maxLines: 10000,
                  hintText: 'write your thoughts here:-',
                  fontSize: 20,
                  textSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
