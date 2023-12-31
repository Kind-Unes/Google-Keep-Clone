import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:google_keep_clone_app/features/home/home.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RemindersPage extends ConsumerWidget {
  final int noteNumber;
  const RemindersPage(this.noteNumber, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
          const MyFloatingActionButton(appBarColor: CLRS.appBarColor),
      bottomNavigationBar: const MyBottomAppBar(appBarColor: CLRS.appBarColor),
      drawer: const MyDrawer(),
      backgroundColor: CLRS.backgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.grid_view,
            ),
            onPressed: () {},
          ),
        ],
        title: const Text(
          "Reminders",
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
                    Icons.notifications_none,
                    color: Color.fromARGB(255, 180, 180, 180),
                    size: 140,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Notes with upcoming reminders appear here",
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
