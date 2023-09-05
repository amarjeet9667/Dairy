import 'package:diary/controllers/diary_controller.dart';
import 'package:diary/helper/common_textfield.dart';
import 'package:diary/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DairyView extends StatefulWidget {
  const DairyView({super.key});

  @override
  State<DairyView> createState() => _DairyViewState();
}

class _DairyViewState extends State<DairyView> {
  final DiaryController _diaryController = Get.put(DiaryController());

  bool showEmojiPicker = false;
  bool showCursor = true;

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
          'Write your Thoughts',
          style: TextStyle(
            color: white,
            fontSize: 20,
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
                  showCursor: showCursor,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
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
      ),
    );
  }
}






              
              
              
              
//....................................................Emoji picker................................................
// if (showEmojiPicker)
                  //   Positioned(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom,
                  //     left: 0,
                  //     right: 0,
                  //     child: SizedBox(
                  //       height: 300,
                  //       child: EmojiPicker(
                  //         onEmojiSelected: (Category? category, Emoji emoji) {
                  //           final text = _diaryController.bodyController.text;
                  //           final selection =
                  //               _diaryController.bodyController.selection;
                  //           if (selection.start >= 0 &&
                  //               selection.end <= text.length) {
                  //             final newText = text.replaceRange(
                  //               selection.start,
                  //               selection.end,
                  //               emoji.emoji,
                  //             );

                  //             _diaryController.bodyController.text = newText;
                  //           }

                  //           // setState(() {
                  //           //   showEmojiPicker = false;
                  //           // });
                  //         },
                  //         config: const Config(
                  //           columns: 7,
                  //           emojiSizeMax: 32.0,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
               