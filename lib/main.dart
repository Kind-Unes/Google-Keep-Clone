import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_keep_clone_app/features/create_note/create_note.dart';
import 'package:google_keep_clone_app/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Note(
          "tiitle",
          "hi i'm unes",
          ""
          // "assets/images/download.jpg"
          ,
          false,
          false,
          false,
          Colors.black,
          ["dsqd"]),
    );
  }
}
