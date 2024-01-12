import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stp/pages/util/shimmer.dart';

class ArticleImage extends StatelessWidget {
  final int pageId;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final bool isRedirecting;

  const ArticleImage._(
      {required this.pageId,
      required this.imageUrl,
      required this.imageWidth,
      required this.imageHeight,
      required this.isRedirecting});

  factory ArticleImage(
      {required int pageId,
      required String imageUrl,
      required int imageWidth,
      required int imageHeight,
      bool? isRedirecting}) {
    return ArticleImage._(
        pageId: pageId,
        imageUrl: imageUrl,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
        isRedirecting: isRedirecting ?? true);
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = imageUrl.endsWith('.svg');
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: GestureDetector(
        onTap: () {
          if (isRedirecting) {
            Navigator.pushNamed(
              context,
              '/page/$pageId',
              arguments: {'pageId': pageId},
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            var containerWidth = constraints.maxWidth;
            var containerHeight = containerWidth * imageHeight / imageWidth;
            if (containerHeight > 500) {
              containerHeight = 500;
            }

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
                        width: containerWidth,
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
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
