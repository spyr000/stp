import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stp/exception/add_to_favourites_exception.dart';
import 'package:stp/pages/article/widget/article_image.dart';
import 'package:stp/pages/article/widget/favourites_button.dart';
import 'package:stp/service/favourites_service.dart';
import 'package:stp/service/network_redirection_service.dart';

class ArticleCard extends StatelessWidget {
  final int pageId;
  final String title;
  final String description;
  final String exIntro;
  final String imageUrl;
  final int imageWidth;
  final int imageHeight;
  final String pageUrl;

  const ArticleCard({
    Key? key,
    required this.pageId,
    required this.title,
    required this.description,
    required this.exIntro,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.pageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(height: 16.0);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          FutureBuilder<bool>(
            future: FavouritesService.isInFavourites(pageId),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.hasError) {
                return const SizedBox(
                  height: 48.0,
                  width: 48.0,
                  child: Material(
                    color: Colors.transparent,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              } else {
                return FavouritesButton(
                  key: ObjectKey("$pageId\_card_add"),
                  onTurningOn: () async {
                    await FavouritesService.saveToFavourites(pageId).onError(
                      (error, stackTrace) =>
                          _handleError(context, error, stackTrace),
                    );
                  },
                  onTurningOff: () async {
                    await FavouritesService.deleteById(pageId).onError(
                      (error, stackTrace) =>
                          _handleError(context, error, stackTrace),
                    );
                  },
                  icon: Icons.bookmark,
                  isAlreadyToggled: snapshot.data ?? false,
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.tertiary.withOpacity(0.1),
              theme.colorScheme.secondary.withOpacity(0.1),
            ],
            transform: const GradientRotation(120),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExpandablePanel(
                header: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
                collapsed: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ArticleImage(
                      pageId: pageId,
                      imageUrl: imageUrl,
                      imageWidth: imageWidth,
                      imageHeight: imageHeight,
                      isRedirecting: false,
                    ),
                    spacer,
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium,
                    ),
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
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.tertiary.withOpacity(0.4),
                          theme.colorScheme.secondary.withOpacity(0.4),
                        ],
                        transform: const GradientRotation(120),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade200.withOpacity(0.1),
                          offset: const Offset(10, 5),
                          spreadRadius: 1,
                          blurRadius: 100,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      child: Html(
                        data: exIntro,
                        style: {
                          "p": Style(
                            fontFamily: 'Montserrat',
                            fontSize: FontSize(16.0),
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              ),
              spacer,
              TextButton(
                onPressed: () => UrlLauncher.launchPageURL(pageUrl),
                child: Text('Открыть в браузере'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleError(
      BuildContext context, Object? error, StackTrace stackTrace) {
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
  }
}
