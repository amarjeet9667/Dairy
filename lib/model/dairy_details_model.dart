import 'package:cloud_firestore/cloud_firestore.dart';

class DairyEntryModel {
  final String userId;
  final String title;
  final String body;
  final DateTime timestamp;
  final String id;

  DairyEntryModel( {
    required this.userId,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.id
  });

  factory DairyEntryModel.fromJson(Map<String, dynamic> json) {
    return DairyEntryModel(
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'timestamp': timestamp,
      'id':id,
    };
  }
}
