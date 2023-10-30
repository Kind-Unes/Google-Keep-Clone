import 'package:hooks_riverpod/hooks_riverpod.dart';

final titleProvider = StateProvider<String>((ref) {
  return "";
});


final contentProvider = StateProvider<String>((ref) {
  return "";
});

// final noteModelProvider = StateNotifierProvider<NoteModelController, NoteModel>(
//   (ref) => NoteModelController(NoteModel.initial()),
// );

// class NoteModelController extends StateNotifier<NoteModel> {
//   NoteModelController(NoteModel state) : super(state);

//   // Add methods to update individual parameters
//   void updateTitle(String title) {
//     state = state.copyWith(title: title);
//   }

//   void updateContent(String content) {
//     state = state.copyWith(content: content);
//   }

//   void updatePictureURL(String pictureURL) {
//     state = state.copyWith(pictureURL: pictureURL);
//   }

//   void toggleIsPinned() {
//     state = state.copyWith(isPinned: !state.isPinned);
//   }

//   void toggleIsArchived() {
//     state = state.copyWith(isArchived: !state.isArchived);
//   }

//   void toggleIsDeleted() {
//     state = state.copyWith(isDeleted: !state.isDeleted);
//   }

//   void updateBackgroundColor(Color color) {
//     state = state.copyWith(backgroundColor: color);
//   }

//   void updateLabels(List<String> labels) {
//     state = state.copyWith(labels: labels);
//}}