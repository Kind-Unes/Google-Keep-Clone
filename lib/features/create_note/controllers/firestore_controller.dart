import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/models/note_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final firestoreProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(firestore: FirebaseFirestore.instance);
});

final allNotesProvider = FutureProvider<List<NoteModel>>((ref) async {
  return ref.watch(firestoreProvider).fetchNotes();
});

final idNoteProvider = FutureProvider.family((ref, String id) async {
  return ref.watch(firestoreProvider).getNoteById(id);
});

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //* Create Operation
  Future<void> createNote() async {
    try {
      final noteModel = NoteModel(
        id: const Uuid().v4(),
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

  Future<NoteModel?> getNoteById(String noteId) async {
    try {
      CollectionReference notesCollection = _firestore.collection('notes');

      Query query = notesCollection.where("id", isEqualTo: noteId);

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        return NoteModel(
          id: document["id"],
          title: document['title'],
          content: document['content'],
          timeStamp: document["timeStamb"],
          userID: document["userID"],
          pictureURL: document["pictureURL"],
          isPinned: document["isPinned"],
          isArchived: document["isArchived"],
          isDeleted: document["isDeleted"],
          backgroundColor: document["backgroundColor"],
          labels: document["labels"],
        );
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  //* Read Operation
  Future<List<NoteModel>> fetchNotes() async {
    final querySnapshot = await _firestore.collection('notes').get();
    return querySnapshot.docs
        .map((doc) => NoteModel.fromMap(doc.data()))
        .toList();
  }

  // update data
  Future<void> updateFieldInDocument(
    String documentId,
    String fieldToUpdate,
    dynamic newValue,
  ) async {
    try {
      DocumentReference documentReference =
          _firestore.collection('notes').doc(documentId);
      Map<String, dynamic> updatedData = {
        fieldToUpdate: newValue,
      };
      await documentReference.update(updatedData);
      print('Field "$fieldToUpdate" updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }
}
