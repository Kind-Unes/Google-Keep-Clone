import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/models/note_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firestoreProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(firestore: FirebaseFirestore.instance);
});

final noteReaderProvider = FutureProvider<List<NoteModel>>((ref) async {
  return ref.watch(firestoreProvider).fetchNotes();
});

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //* Create Operation
  Future<void> createNote() async {
    try {
      final noteModel = NoteModel(
        timeStamp: FieldValue.serverTimestamp(),
        title: "",
        content: "",
        pictureURL: "",
        isPinned: false,
        isArchived: false,
        isDeleted: false,
        backgroundColor: CLRS.backgroundColor,
        labels: [],
        userID: 'YOUR_USER_ID',
      );

      await _firestore.collection("notes").add(noteModel.toMap());
    } catch (e) {
      debugPrint(
          "---------------------------$e------------------------------------");
    }
  }

  //* Read Operation
  Future<List<NoteModel>> fetchNotes() async {
    final querySnapshot = await _firestore.collection('notes').get();
    return querySnapshot.docs
        .map((doc) => NoteModel.fromMap(doc.data()))
        .toList();
  }
}
