import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stp/exception/add_to_favourites_exception.dart';
import 'package:stp/feed/page/page_image.dart';
import 'package:stp/feed/page/shimmer.dart';
import 'package:stp/service/favourites_service.dart';
import 'package:stp/service/network_redirection_service.dart';
import 'package:stp/feed/page/page_item.dart';

import 'button/page_item_button.dart';

class PageCard extends StatelessWidget {
  final int pageId;
  final String title;
  final String description;
  final String exIntro;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final String pageUrl;

  const PageCard({
    super.key,
    required this.pageId,
    required this.title,
    required this.description,
    required this.exIntro,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.pageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16.0);
    const titleTextStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    final descriptionText = Text(
      description,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18.0,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: titleTextStyle,
        ),
        actions: [
          PageItemButton(
            key: ObjectKey("$pageId\_card_add"),
            onTurningOn: () async {
              await FavouritesService.save(pageId).onError((error, stackTrace) {
                var message = error.toString();
                SnackBarAction? action;
                if (error is AddToFavouritesException) {
                  message = error.message ?? message;
                  if (error.code == 'unauthorized') {
                    action = SnackBarAction(
                      label: 'Login',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    );
                  }
                }
                final snackBar = SnackBar(
                  content: Text(message),
                  action: action,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            onTurningOff: () {  },
            icon: Icons.bookmark,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpandablePanel(
              header: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              collapsed: descriptionText,
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PageImage(
                    pageId: pageId,
                    imageUrl: imageUrl,
                    imageWidth: imageWidth,
                    imageHeight: imageHeight,
                    isRedirecting: false,
                  ),
                  spacer,
                  descriptionText,
                ],
              ),
              controller: ExpandableController(initialExpanded: true),
            ),
            spacer,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: 170,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent.withOpacity(0.4),
                        Colors.deepOrange.withOpacity(0.4),
                      ], transform: const GradientRotation(120)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.shade200.withOpacity(0.1),
                            offset: const Offset(10, 5),
                            spreadRadius: 1,
                            blurRadius: 100)
                      ]),
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    child: Html(
                      data: exIntro,
                      style: {
                        "p": Style(
                          fontSize: FontSize(16.0),
                        ),
                        // Define styles for other HTML tags as needed
                      },
                    ),
                  ),
                ),
              ),
            ),
            spacer,
            TextButton(
              onPressed: () => UrlLauncher.launchPageURL(pageUrl),
              child: const Text('Open in browser'),
            ),
          ],
        ),
      ),
    );
  }
}
