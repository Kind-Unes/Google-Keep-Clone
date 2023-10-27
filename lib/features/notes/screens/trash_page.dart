import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/features/home/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrashPage extends ConsumerWidget {
  final int noteNumber;
  const TrashPage(this.noteNumber, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: CLRS.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Trash",
          style: TextStyle(fontFamily: "google", fontWeight: FontWeight.w300),
        ),
        backgroundColor: CLRS.backgroundColor,
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Use the new context
              },
              icon: const Icon(
                FontAwesomeIcons.bars,
                color: Colors.grey,
              ));
        }),
      ),
      body: noteNumber == 0
          ? const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline_outlined,
                    color: Color.fromARGB(255, 180, 180, 180),
                    size: 140,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "No notes in Trash",
                    style: TextStyle(
                        color: Color.fromARGB(255, 180, 180, 180),
                        fontSize: 17,
                        fontFamily: "google"),
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
