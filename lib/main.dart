import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 21, 21, 21);
    const appBarColor = Color.fromARGB(255, 32, 26, 26);
    const greyColor = Colors.grey;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {},
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  toolbarHeight: 70,
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
                                horizontal: 10, vertical: 5),
                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Row(children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.bars,
                                    color: greyColor,
                                  )),
                              const Text(
                                "Search your notes",
                                style: TextStyle(
                                    color: greyColor,
                                    fontSize: 20,
                                    fontFamily: "google",
                                    fontWeight: FontWeight.w600),
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(color: backgroundColor),
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('Item $index'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
