import 'package:flutter/material.dart';
import 'package:stp/pages/article/widget/article_image.dart';
import 'package:stp/pages/util/shimmer.dart';
import 'package:stp/service/network_redirection_service.dart';
import 'package:stp/pages/article/widget/favourites_button.dart';

class ArticleItem extends StatelessWidget {
  final int pageId;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final String title;
  final String description;
  final String pageUrl;

  // Private constructor
  const ArticleItem._({
    required this.pageId,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.description,
    required this.pageUrl,
  });

  factory ArticleItem({
    required int pageId,
    required String imageUrl,
    required int imageWidth,
    required int imageHeight,
    required String title,
    required String description,
    required String pageUrl,
  }) {
    return ArticleItem._(
      pageId: pageId,
      imageUrl: imageUrl,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      title: title,
      description: description,
      pageUrl: pageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: Colors.redAccent[50],
      surfaceTintColor: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.deepOrange[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            margin: const EdgeInsets.all(16.0),
            child: ArticleImage(
              pageId: pageId,
              imageUrl: imageUrl,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //TODO: PUT IN SEPARATE CLASS
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 48.0,
                ),
                child: IconButton(
                  onPressed: () => UrlLauncher.launchPageURL(pageUrl),
                  icon: Icon(
                    Icons.link,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              // PageItemButton(
              //   key: ObjectKey("$pageId\_add"),
              //   onTurningOn: () => {},
              //   onTurningOff: () {  },
              //   icon: Icons.bookmark,
              // )
            ],
          ),
        ],
      ),
    );
  }
}
