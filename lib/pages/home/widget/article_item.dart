import 'package:flutter/material.dart';
import 'package:stp/pages/article/widget/article_image.dart';
import 'package:stp/service/network_redirection_service.dart';

class ArticleItem extends StatelessWidget {
  final int pageId;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final String title;
  final String description;
  final String pageUrl;

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
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      color: theme.cardColor,
      surfaceTintColor: theme.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: theme.colorScheme.secondary,
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
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 48.0,
                ),
                child: IconButton(
                  onPressed: () => UrlLauncher.launchPageURL(pageUrl),
                  icon: Icon(
                    Icons.link,
                    color: theme.iconTheme.color,
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
