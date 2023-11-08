import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_keep_clone_app/models/note_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firestoreProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(firestore: FirebaseFirestore.instance);
});

final allNotesProvider = FutureProvider<List<NoteModel>>((ref) async {
  return ref.watch(firestoreProvider).fetchNotes();
});

final idNoteProvider = StreamProvider.family<NoteModel?, String>((ref, noteId) {
  return ref.watch(firestoreProvider).getNoteByIdStream(noteId);
});

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  //* Create Operation

  Future<Either<String, String>> createNote() async {
    try {
      final String id = const Uuid().v4();
      final noteModel = NoteModel(
        id: id,
        userID: 'YOUR_USER_ID',
        labels: [],
        timeStamp: Timestamp.now(),
        title: "",
        content: "",
        pictureURL: "",
        isPinned: false,
        isArchived: false,
        isDeleted: false,
      );

      await _firestore.collection("notes").add(noteModel.toMap());

      return Right(id); // Return the generated ID on success
    } catch (e) {
      debugPrint(
          "---------------------------$e------------------------------------");
      return Left("Error: $e"); // Return an error message on failure
    }
  }

  Stream<NoteModel?> getNoteByIdStream(String noteId) {
    try {
      final notesCollection = _firestore.collection('notes');
      final query = notesCollection.where("id", isEqualTo: noteId);

      return query.snapshots().map((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          final document = querySnapshot.docs.first;
          final data = document.data();

          return NoteModel(
            id: document.id,
            title: data['title'],
            content: data['content'],
            timeStamp: data['timeStamp'],
            userID: data['userID'],
            pictureURL: data['pictureURL'],
            isPinned: data['isPinned'],
            isArchived: data['isArchived'],
            isDeleted: data['isDeleted'],
            labels: data['labels'],
          );
        } else {
          return null;
        }
      });
    } catch (e) {
      debugPrint('Error: $e');
      return Stream.value(null); // Return an empty stream in case of an error*

      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///*
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      ///
      /////
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
    String noteId,
    String fieldToUpdate,
    dynamic newValue,
  ) async {
    try {
      CollectionReference notesCollection = _firestore.collection('notes');
      Query query = notesCollection.where("id", isEqualTo: noteId);
      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document that matches the query
        DocumentSnapshot document = querySnapshot.docs.first;

        // Update the specific field in the document
        Map<String, dynamic> updatedData = {
          fieldToUpdate: newValue,
        };

        await document.reference.update(updatedData);
        print('Field "$fieldToUpdate" updated successfully.');
      } else {
        print('No document found with noteId: $noteId');
      }
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      CollectionReference notesCollection = _firestore.collection('notes');
      Query query = notesCollection.where("id", isEqualTo: noteId);
      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document that matches the query
        DocumentSnapshot document = querySnapshot.docs.first;
        await document.reference.delete();
      }

      print('Note with ID $noteId deleted successfully.');
    } catch (e) {
      print('Error deleting note: $e');
      // You can handle errors or propagate them as needed.
      rethrow;
    }
  }
}
