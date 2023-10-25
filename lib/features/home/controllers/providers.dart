import 'package:riverpod/riverpod.dart';

final columnViewProvider = StateProvider<bool>((ref) {
  return true;
});

final drawerIndexProvider = StateProvider<int>((ref) {
  return 0;
});


final notesIndexProvider = StateProvider<int>((ref) {
  return 0;
});
