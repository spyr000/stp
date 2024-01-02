import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stp/feed/page/button/page_item_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PageItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String pageUrl;

  const PageItem(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.pageUrl});

  @override
  Widget build(BuildContext context) {
    final isSvg = imageUrl.endsWith('.svg');
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.redAccent[50],
      surfaceTintColor: Colors.red,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: Colors.deepOrange[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: isSvg
                      ? SvgPicture.network(
                          imageUrl,
                          height: 200.0, // Adjust the height as needed
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          imageUrl,
                          height: 200.0, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PageItemButton(
                  key: ObjectKey("$title\_link"),
                  onPressed: () => _launchURL(pageUrl),
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
        ],
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final url =
        Uri.tryParse(urlString) ?? Uri.https('https://wikipedia.org', '/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
