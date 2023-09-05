import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary/helper/constants.dart';
import 'package:diary/model/dairy_details_model.dart';
import 'package:diary/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  RxList<DairyEntryModel> diaryEntry = <DairyEntryModel>[].obs;

  Stream<List<DairyEntryModel>> fetchDiaryEntry() {
    final uid = firebaseAuth.currentUser!.uid;
    final streamController = StreamController<List<DairyEntryModel>>();

    firestore
        .collection('Users')
        .doc(uid)
        .collection('Thoughts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      List<DairyEntryModel> entries = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return DairyEntryModel(
          userId: data['userId'],
          title: data['title'],
          body: data['body'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          id: doc.id,
        );
      }).toList();

      streamController.add(entries);
    });

    return streamController.stream;
  }

  deleteEntry(String id) async {
    final uid = firebaseAuth.currentUser!.uid;

    await firestore
        .collection('Users')
        .doc(uid)
        .collection('Thoughts')
        .doc(id)
        .delete();
  }

  saveThoughts({
    required String userId,
    required DateTime timestamp,
  }) async {
    String title = titleController.text;
    String body = bodyController.text;

    final uid = firebaseAuth.currentUser!.uid;
    final firebaseFirestore =
        await firestore.collection('Users').where('uid', isEqualTo: uid).get();
    if (firebaseFirestore.docs.isEmpty) {
      await firestore.collection('Users').doc(uid).collection('Thoughts').add({
        'userId': userId,
        'title': title,
        'body': body,
        'timestamp': timestamp,
      }).then((value) {
        Get.offAll(const HomeView());
      });
    } else {
      Get.offAll(const HomeView());
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
