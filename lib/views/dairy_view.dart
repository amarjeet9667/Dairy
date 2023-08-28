import 'package:diary/controllers/diary_controller.dart';
import 'package:diary/helper/common_textfield.dart';
import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DairyView extends GetView {
  final DiaryController _diaryController = Get.put(DiaryController());

  DairyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: green,
          automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
          title: const Text(
            'Writeyour Thoughts',
            style: TextStyle(
              color: white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
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
                  controller: _diaryController.titleController,
                  hintText: 'Title:-',
                  maxLines: 5,
                  fontSize: 25,
                  textSize: 25,
                  textWeight: FontWeight.w600,
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
                    controller: _diaryController.bodyController,
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: green,
          onPressed: () {
            String userId = firebaseAuth.currentUser!.uid;
            DateTime timestamp = DateTime.now();
            _diaryController.saveThoughts(
              userId: userId,
              timestamp: timestamp,
            );
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
