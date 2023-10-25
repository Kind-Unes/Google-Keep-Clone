import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_keep_clone_app/features/home/controllers/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    const backgroundColor = Color.fromARGB(255, 21, 21, 21);
    const appBarColor = Color.fromARGB(255, 32, 26, 26);
    const greyColor = Colors.grey;

    void switchView() {
      ref.read(columnViewProvider.notifier).update((state) => !state);
    }

    final bool isMultiColumnView = ref.watch(columnViewProvider);
    return Scaffold(
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
            isMultiColumnView
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          decoration:
                              const BoxDecoration(color: backgroundColor),
                          child: ListTile(
                            textColor: Colors.white,
                            title: Text('Item $index'),
                          ),
                        );
                      },
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          decoration:
                              const BoxDecoration(color: backgroundColor),
                          child: ListTile(
                            textColor: Colors.white,
                            title: Text('Item $index'),
                          ),
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
            isSelected: true,
            icon: Icons.lightbulb_outline,
            text: 'Notes',
            path: '',
          ),
          // const DrawerListTile(
          //   icon: Icons.notifications_none,
          //   text: 'Reminders',
          //   path: '',
          // ),
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
          )
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
      scaleX: 1.1,
      child: const Divider(
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Color.fromARGB(82, 255, 153, 0)),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String path;
  final bool isSelected;
  const DrawerListTile({
    super.key,
    required this.icon,
    required this.text,
    required this.path,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(500),
      onTap: () {},
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: isSelected ? const Color.fromARGB(33, 255, 153, 0) : null,
            borderRadius: BorderRadius.circular(500)),
      ),
    );
  }
}



// Transform.scale(
//       scaleX: 1.05,
//       child: ListTile(
//         iconColor: Colors.grey,
//         textColor: Colors.grey,
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(
//           borderRadius:
//               BorderRadius.circular(500), // Customize the border radius
//         ),
//         tileColor: Colors.blue, // Set the background color

//         leading:
//             Transform.translate(offset: const Offset(10, 0), child: Icon(icon)),
//         title: Text(
//           text,
//           style: const TextStyle(
//               fontSize: 16.5,
//               fontFamily: "google",
//               fontWeight: FontWeight.w400),
//         ),
//         onTap: () {
//           context.goNamed("hi");
//         },
//       ),
//     );