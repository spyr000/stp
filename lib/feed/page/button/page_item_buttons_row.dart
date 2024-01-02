import 'package:flutter/material.dart';
import 'package:stp/feed/page/button/page_item_button.dart';

class PageItemButtonsRow extends StatelessWidget {
  final String title;
  final String pageUrl;

  const PageItemButtonsRow(
      {Key? key, required this.title, required this.pageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageItemButton(
              key: ObjectKey("$title\_link"),
              onPressed: () => {print(pageUrl)},
              isChangingColorOnPress: false,
              icon: Icons.link,
            ),
            PageItemButton(
              key: ObjectKey("$title\_add"),
              onPressed: () => {},
              isChangingColorOnPress: true,
              icon: Icons.bookmark,
            )
          ],
        ),
      ),
    );
  }
}
