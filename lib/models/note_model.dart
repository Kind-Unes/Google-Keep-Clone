// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class NoteModel {
  final String title;
  final String content;
  final String pictureURL;
  final bool isPinned;
  final bool isArchived;
  final bool isDeleted;
  final Color backgroundColor;
  final List<String> labels;
  NoteModel({
    required this.title,
    required this.content,
    required this.pictureURL,
    required this.isPinned,
    required this.isArchived,
    required this.isDeleted,
    required this.backgroundColor,
    required this.labels,
  });

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
        ));
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
