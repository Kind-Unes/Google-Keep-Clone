import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final Timestamp timeStamp;
  final String id;
  final String userID;
  final String title;
  final String content;
  final String pictureURL;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final List<dynamic> labels;

  NoteModel({
    required this.timeStamp,
    required this.id,
    required this.userID,
    required this.title,
    required this.content,
    required this.pictureURL,
    required this.isPinned,
    required this.isArchived,
    required this.isDeleted,
    required this.labels,
  });

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'id': id,
      'userID': userID,
      'title': title,
      'content': content,
      'pictureURL': pictureURL,
      'isPinned': isPinned,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'labels': labels,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      timeStamp: map['timeStamp'] as Timestamp,
      id: map['id'] as String,
      userID: map['userID'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      pictureURL: map['pictureURL'] as String,
      isPinned: map['isPinned'] as bool,
      isArchived: map['isArchived'] as bool,
      isDeleted: map['isDeleted'] as bool,
      labels: List<dynamic>.from(map['labels'] as List<dynamic>),
    );
  }
}
