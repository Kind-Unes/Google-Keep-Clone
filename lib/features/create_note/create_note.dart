import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/features/create_note/controllers/firestore_controller.dart';
import 'package:google_keep_clone_app/features/create_note/controllers/providers.dart';
import 'package:google_keep_clone_app/utils/snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Note extends ConsumerWidget {
  final String noteId;
  const Note(this.noteId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: CLRS.appBarColor,
    ));

    final noteProvider = ref.watch(idNoteProvider(noteId));
    final myProvider = ref.watch(firestoreProvider);

    Future<void> updateNoteData(
        String documentId, String fieldToUpdate, dynamic newValue) async {
      myProvider.updateFieldInDocument(documentId, fieldToUpdate, newValue);
    }

    final title = ref.watch(titleProvider);
    final content = ref.watch(contentProvider);

    return WillPopScope(
      onWillPop: () async {
        if (title.isEmpty && content.isEmpty) {
          myProvider.deleteNote(noteId);
          showSnackbar(context, "Note has been deleted because it was empty.");
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: CLRS.appBarColor,
          height: 55,
          elevation: 0,
          child: Row(children: [
            const SizedBox(width: 5),
            IconButton(
              onPressed: () {},
              tooltip: "New list",
              icon: const Icon(
                Icons.add_box_outlined,
                size: 30,
              ),
              color: Colors.grey,
            ),
            const SizedBox(width: 9),
            IconButton(
              onPressed: () {},
              tooltip: "New list",
              icon: const Icon(
                Icons.color_lens_outlined,
                size: 30,
              ),
              color: Colors.grey,
            ),
            const SizedBox(width: 50),
            IconButton(
              onPressed: () {},
              tooltip: "New list",
              icon: const Icon(
                Icons.undo_outlined,
                size: 30,
              ),
              color: Colors.grey,
            ),
            const SizedBox(width: 9),
            IconButton(
              onPressed: () {},
              tooltip: "New list",
              icon: const Icon(
                Icons.redo_outlined,
                size: 30,
              ),
              color: Colors.grey,
            ),
            const SizedBox(width: 79),
            IconButton(
              onPressed: () {},
              tooltip: "New list",
              icon: const Icon(
                Icons.more_vert,
                size: 30,
              ),
              color: Colors.grey,
            ),
          ]),
        ),
        backgroundColor: CLRS.backgroundColor,
        appBar: AppBar(
            backgroundColor: CLRS.backgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.thumbtack,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notification_add_outlined,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.system_update_tv_rounded,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 5),
            ]),
        body: noteProvider.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
          data: (note) {
            if (note == null) {
              return const Text('No data available');
            }
            print(note.title);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  note.pictureURL.trim().isNotEmpty
                      ? NotePicture(pictureURL: note.pictureURL)
                      : Container(),
                  const SizedBox(height: 20),
                  NoteTextFeild(
                    maxLines: 2,
                    fontSize: 27,
                    hint: "Title",
                    text: note.title,
                    onChanged: (String newText) {
                      updateNoteData(note.id, "title", newText);
                    },
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: NoteTextFeild(
                      maxLines: 1000,
                      hint: "Note",
                      fontSize: 20,
                      text: note.content,
                      onChanged: (String newText) {
                        updateNoteData(note.id, "content", newText);

                        ref
                            .watch(contentProvider.notifier)
                            .update((state) => newText);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NoteTextFeild extends StatelessWidget {
  const NoteTextFeild({
    super.key,
    required this.fontSize,
    required this.hint,
    required this.text,
    required this.maxLines,
    required this.onChanged,
  });
  final Function(String) onChanged;
  final String text;
  final double fontSize;
  final String hint;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onChanged: onChanged,
        controller: TextEditingController(text: text),
        textAlign: TextAlign.start,
        cursorColor: Colors.white,
        maxLines: maxLines,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle:
                const TextStyle(color: Color.fromARGB(122, 255, 255, 255))),
        style: TextStyle(
            fontFamily: "google", color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}

class NotePicture extends StatelessWidget {
  const NotePicture({
    super.key,
    required this.pictureURL,
  });

  final String pictureURL;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO: route + modify
      },
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
          child: Image(
            image: AssetImage(pictureURL),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
