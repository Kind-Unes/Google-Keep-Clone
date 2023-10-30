import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_keep_clone_app/features/create_note/controllers/firestore_controller.dart';
import 'package:google_keep_clone_app/features/create_note/create_note.dart';
import 'package:google_keep_clone_app/features/home/controllers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:readmore/readmore.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    const appBarColor = Color.fromARGB(255, 32, 26, 26);
    const greyColor = Colors.grey;
    const backgroundColor = Color.fromARGB(255, 21, 21, 21);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: appBarColor, // Change this color
    ));

    void switchView() {
      ref.read(columnViewProvider.notifier).update((state) => !state);
    }

    final bool isMultiColumnView = ref.watch(columnViewProvider);
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton:
          const MyFloatingActionButton(appBarColor: appBarColor),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: const MyBottomAppBar(appBarColor: appBarColor),
      drawer: const MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 75,
                backgroundColor: backgroundColor,
                pinned: false,
                elevation: 0,
                floating: true,
                flexibleSpace: Column(
                  children: [
                    const SizedBox(
                      height: 65,
                    ),
                    Material(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(500),
                      child: InkWell(
                        onTap: () {
                          //trigger the Search bar
                        },
                        borderRadius: BorderRadius.circular(500),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.93,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Row(children: [
                            const SizedBox(
                              width: 3,
                            ),
                            Builder(builder: (context) {
                              return IconButton(
                                  onPressed: () {
                                    Scaffold.of(context)
                                        .openDrawer(); // Use the new context
                                  },
                                  icon: const Icon(
                                    FontAwesomeIcons.bars,
                                    color: greyColor,
                                  ));
                            }),
                            const Text(
                              "Search your notes",
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: 21,
                                  fontFamily: "google",
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 42,
                            ),
                            IconButton(
                                onPressed: () {
                                  //switch the grid view
                                  switchView();
                                },
                                icon: Icon(
                                  isMultiColumnView
                                      ? Icons.grid_view
                                      : FontAwesomeIcons.gripLines,
                                  size: 27,
                                  color: greyColor,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(500),
                              onTap: () {
                                // Google Auhtentication
                              },
                              child: const CircleAvatar(
                                radius: 17,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 111, 0),
                                child: Text(
                                  "Y",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 2,
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(500),
                        ),
                      ),
                    ),
                  ],
                )),
            if (isMultiColumnView)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return NoteWidget(
                      index: index,
                      title: 'qsdsq',
                      content: 'dsq',
                      pictureURL: 'assets/images/download.jpg',
                    );
                  },
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ListTile(
                      textColor: Colors.white,
                      title: Text('Item $index'),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends ConsumerWidget {
  const MyFloatingActionButton({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  Widget build(BuildContext context, ref) {
    final myProvider = ref.watch(firestoreProvider);
    return FloatingActionButton(
      backgroundColor: appBarColor,
      tooltip: "Create New Note",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: () async {
        final result = await myProvider.createNote();
        result.fold((l) {
          //Do Nothing
        }, (id) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Note(id)),
          );
        });
      },
      child: const SizedBox(
        height: 40,
        width: 40,
        child: Image(
          image: AssetImage(
            "assets/icons/icons8-plus-100-removebg-preview.png",
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    super.key,
    required this.appBarColor,
  });

  final Color appBarColor;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: appBarColor,
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
            Icons.check_box_outlined,
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
            Icons.draw_outlined,
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
            Icons.mic_none_outlined,
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
            Icons.photo_outlined,
            size: 30,
          ),
          color: Colors.grey,
        ),
        const SizedBox(
          width: 9,
        ),
      ]),
    );
  }
}

class NoteWidget extends StatelessWidget {
  final int index;
  final String title;
  final String content;
  final String pictureURL;

  const NoteWidget({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    required this.pictureURL,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 21, 21, 21);
    const borderColor = Color.fromARGB(255, 61, 61, 52);

    return Padding(
        padding: EdgeInsets.fromLTRB(8, index == 0 ? 16 : 6, 3, 8),
        child: Material(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 1),
                  borderRadius: BorderRadius.circular(15)),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pictureURL.trim().isEmpty)
                    Container()
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero),
                        child: Image(
                          image: AssetImage(pictureURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  title.trim().isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ReadMoreText(
                            title,
                            trimLines: 9,
                            style: const TextStyle(
                                fontFamily: "google",
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                  title.trim().isEmpty
                      ? Container()
                      : const SizedBox(
                          height: 16,
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ReadMoreText(
                      content,
                      trimLines: 9,
                      trimMode: TrimMode.Line,
                      textAlign: TextAlign.justify,
                      trimCollapsedText: " ",
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 21, 21, 21);

    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 8),
        children: <Widget>[
          const Text(
            ' Google Keep',
            style: TextStyle(
                fontFamily: "google",
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          const DrawerListTile(
            index: 0,
            icon: Icons.lightbulb_outline,
            text: 'Notes',
            path: '',
          ),
          const DrawerListTile(
            icon: Icons.notifications_none,
            text: 'Reminders',
            path: '',
            index: 1,
          ),
          const MyDivider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            iconColor: Colors.grey,
            textColor: Colors.grey,
            title: const Text(
              "Labels",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "google",
                  fontWeight: FontWeight.w400),
            ),
            trailing: Transform.translate(
              offset: const Offset(-20, 0),
              child: InkWell(
                onTap: () {
                  //editpage
                },
                borderRadius: BorderRadius.circular(500),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(500)),
                  alignment: Alignment.center,
                  height: 30,
                  width: 60,
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "google",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          const DrawerListTile(
            icon: Icons.label_outline_rounded,
            text: 'ESI-Notes',
            path: '',
            index: 02,
          ),
          const DrawerListTile(
            icon: Icons.add,
            text: 'Create new label',
            path: '',
            index: 03,
          ),
          const MyDivider(),
          const DrawerListTile(
            icon: Icons.archive_outlined,
            text: 'Archive',
            path: '',
            index: 04,
          ),
          const DrawerListTile(
            icon: Icons.delete_outlined,
            text: 'Trash',
            path: '',
            index: 05,
          ),
          const DrawerListTile(
            icon: Icons.settings,
            text: 'Settings',
            path: '',
            index: 06,
          ),
          const DrawerListTile(
            icon: Icons.help_outline,
            text: 'Help & feedback',
            path: '',
            index: 07,
          ),
        ],
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: 1.06,
      child: const Divider(
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Color.fromARGB(82, 255, 153, 0)),
    );
  }
}

class DrawerListTile extends ConsumerWidget {
  final IconData icon;
  final String text;
  final String path;
  final int index;
  const DrawerListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.path,
    required this.index,
  });

  @override
  Widget build(BuildContext context, ref) {
    final int currentIndex = ref.watch(drawerIndexProvider);
    final isSelected = index == currentIndex;

    return InkWell(
      borderRadius: BorderRadius.circular(500),
      onTap: () {
        // context.goNamed(path);

        //update the index
        ref.read(drawerIndexProvider.notifier).update((state) => index);
      },
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: isSelected ? const Color.fromARGB(32, 255, 153, 0) : null,
            borderRadius: BorderRadius.circular(500)),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              color: isSelected
                  ? const Color.fromARGB(198, 242, 226, 178)
                  : Colors.grey,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16.5,
                  fontFamily: "google",
                  color: isSelected
                      ? const Color.fromARGB(198, 242, 226, 178)
                      : Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
