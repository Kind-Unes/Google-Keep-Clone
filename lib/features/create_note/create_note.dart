import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_keep_clone_app/common/presentation/theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Note extends ConsumerWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: CLRS.backgroundColor,
      appBar: AppBar(backgroundColor: CLRS.appBarColor, actions: [
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // if (pictureURL.trim().isEmpty)
            //   Container()
            // else
            //   SizedBox(
            //     width: double.infinity,
            //     child: ClipRRect(
            //       borderRadius: const BorderRadius.only(
            //           topLeft: Radius.circular(15),
            //           topRight: Radius.circular(15),
            //           bottomLeft: Radius.zero,
            //           bottomRight: Radius.zero),
            //       child: Image(
            //         image: AssetImage(pictureURL),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // const SizedBox(
            //   height: 20,
            // ),
            // titleLarge.trim().isEmpty
            //     ? Container()
            //     : Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 15),
            //         child: ReadMoreText(
            //           titleLarge,
            //           trimLines: 9,
            //           style: const TextStyle(
            //               fontFamily: "google",
            //               color: Colors.white,
            //               fontSize: 22),
            //         ),
            //       ),
            // titleLarge.trim().isEmpty
            //     ? Container()
            //     : const SizedBox(
            //         height: 16,
            //       ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   child: ReadMoreText(
            //     content,
            //     trimLines: 9,
            //     trimMode: TrimMode.Line,
            //     textAlign: TextAlign.justify,
            //     trimCollapsedText: " ",
            //     style: const TextStyle(color: Colors.white, fontSize: 17),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // )
          ],
        ),
      ),
    );
  }
}
