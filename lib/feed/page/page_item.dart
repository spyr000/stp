import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stp/feed/page/shimmer.dart';
import 'package:stp/service/network_redirection_service.dart';
import 'package:stp/feed/page/button/page_item_button.dart';

class PageItem extends StatelessWidget {
  final Key? key;
  final int pageId;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final String title;
  final String description;
  final String pageUrl;

  // Private constructor
  const PageItem._({
    this.key,
    required this.pageId,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.title,
    required this.description,
    required this.pageUrl,
  });

  factory PageItem({
    Key? key,
    required int pageId,
    required String imageUrl,
    required int imageWidth,
    required int imageHeight,
    required String title,
    required String description,
    required String pageUrl,
  }) {
    return PageItem._(
      key: key,
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
    final isSvg = imageUrl.endsWith('.svg');
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
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/page/$pageId',
                      arguments: {'pageId': pageId},
                    );
                  },
                  child: LayoutBuilder(
                    builder: (context, constraints) {

                      var containerWidth = constraints.maxWidth;
                      var containerHeight = containerWidth * imageHeight / imageWidth;

                      return SizedBox(
                        height: containerHeight,
                        width: containerWidth,
                        child: isSvg
                            ? SvgPicture.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                height: containerHeight,
                                width: containerWidth,
                                placeholderBuilder: (context) => ShimmerImage(
                                  height: containerHeight,
                                    width: containerWidth
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                                height: containerHeight,
                                width: containerWidth,
                                placeholder: (context, url) => ShimmerImage(
                                  height: containerHeight,
                                  width: containerWidth,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      );
                    },
                  ),
                )),
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
              PageItemButton(
                key: ObjectKey("$pageId\_link"),
                onPressed: () => UrlLauncher.launchPageURL(pageUrl),
                isChangingColorOnPress: false,
                icon: Icons.link,
              ),
              PageItemButton(
                key: ObjectKey("$pageId\_add"),
                onPressed: () => {},
                isChangingColorOnPress: true,
                icon: Icons.bookmark,
              )
            ],
          ),
        ],
      ),
    );
  }
}
