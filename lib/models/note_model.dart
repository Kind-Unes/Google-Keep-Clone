// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';

class NoteModel {
  final FieldValue timeStamp;
  final String userID;
  final String title;
  final String content;
  final String pictureURL;
  final bool isPinned; //* Nice Ideq
  final bool isArchived; //* Nice Ideq
  final bool isDeleted; //* Nice Ideq
  final List<String> labels;
  final Color backgroundColor;
  NoteModel({
    required this.timeStamp,
    required this.userID,
    required this.title,
    required this.content,
    required this.pictureURL,
    required this.isPinned,
    required this.isArchived,
    required this.isDeleted,
    required this.backgroundColor,
    required this.labels,
  });

  // Add a static method to create an initial instance of NoteModel
  static NoteModel initial() {
    return NoteModel(
      timeStamp: FieldValue.serverTimestamp(),
      userID: '',
      title: '',
      content: '',
      pictureURL: '',
      isPinned: false,
      isArchived: false,
      isDeleted: false,
      backgroundColor: CLRS.backgroundColor,
      labels: [],
    );
  }

  NoteModel copyWith({
    String? title,
    String? content,
    String? pictureURL,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    Color? backgroundColor,
    List<String>? labels,
  }) {
    return NoteModel(
      title: title ?? this.title,
      content: content ?? this.content,
      pictureURL: pictureURL ?? this.pictureURL,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labels: labels ?? this.labels,
      userID: '',
      timeStamp: FieldValue.serverTimestamp(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'pictureURL': pictureURL,
      'isPinned': isPinned,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      'backgroundColor': backgroundColor.value,
      'labels': labels,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        title: map['title'] as String,
        content: map['content'] as String,
        pictureURL: map['pictureURL'] as String,
        isPinned: map['isPinned'] as bool,
        isArchived: map['isArchived'] as bool,
        isDeleted: map['isDeleted'] as bool,
        backgroundColor: Color(map['backgroundColor'] as int),
        labels: List<String>.from(
          (map['labels'] as List<String>),
        ),
        userID: map["userID"] as String,
        timeStamp: map["timeStamp"] as FieldValue);
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NoteModel(title: $title, content: $content, pictureURL: $pictureURL, isPinned: $isPinned, isArchived: $isArchived, isDeleted: $isDeleted, backgroundColor: $backgroundColor, labels: $labels)';
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.pictureURL == pictureURL &&
        other.isPinned == isPinned &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        other.backgroundColor == backgroundColor &&
        listEquals(other.labels, labels);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        pictureURL.hashCode ^
        isPinned.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        backgroundColor.hashCode ^
        labels.hashCode;
  }
}
