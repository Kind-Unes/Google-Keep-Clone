import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/features/create_note/controllers/firestore_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Note extends ConsumerWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Saving stuff

    // Status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: CLRS.appBarColor, // Change this color
    ));

    final notesProvider = ref.watch(noteReaderProvider);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: CLRS.appBarColor,
        height: 55,
        elevation: 0,
        child: Row(children: [
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {},
            tooltip: "New list",
            icon: const Icon(
              Icons.add_box_outlined,
              size: 30,
            ),
            color: Colors.grey,
          ),
          const SizedBox(
            width: 9,
          ),
          IconButton(
            onPressed: () {},
            tooltip: "New list",
            icon: const Icon(
              Icons.color_lens_outlined,
              size: 30,
            ),
            color: Colors.grey,
          ),
          const SizedBox(
            width: 50,
          ),
          IconButton(
            onPressed: () {},
            tooltip: "New list",
            icon: const Icon(
              Icons.undo_outlined,
              size: 30,
            ),
            color: Colors.grey,
          ),
          const SizedBox(
            width: 9,
          ),
          IconButton(
            onPressed: () {},
            tooltip: "New list",
            icon: const Icon(
              Icons.redo_outlined,
              size: 30,
            ),
            color: Colors.grey,
          ),
          const SizedBox(
            width: 79,
          ),
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
      appBar:
          AppBar(backgroundColor: CLRS.backgroundColor, elevation: 0, actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.thumbtack,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notification_add_outlined,
            size: 30,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.system_update_tv_rounded,
            size: 30,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ]),
      body: notesProvider.when(
          // TODO ::                                                                     I STOPPED HERE
          // you should replace this in other place
          // have a solution for the data loaded (last one vs by id)
          // if  first created we used last one
          // if clicked form the home we use id but how we acceed (ask gpt)
          //we set a provider then we route then we call the provider
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
          data: (note) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  note.title.trim().isEmpty
                      ? NotePicture(pictureURL: pictureURL)
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  NoteTextFeild(
                    maxLines: 2,
                    fontSize: 27,
                    hint: "Title",
                    text: titleLarge,
                  ),
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: NoteTextFeild(
                      maxLines: 1000,
                      hint: "Note",
                      fontSize: 20,
                      text: content,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }),
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
  });

  final String text;
  final double fontSize;
  final String hint;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
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
