import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stp/feed/page/shimmer.dart';
import 'package:stp/service/network_redirection_service.dart';
import 'package:stp/feed/page/page_item.dart';

class PageCard extends StatelessWidget {
  final int pageId;
  final String title;
  final String description;
  final String exIntro;
  final String imageUrl;
  final String pageUrl;

  const PageCard({
    super.key,
    required this.pageId,
    required this.title,
    required this.description,
    required this.exIntro,
    required this.imageUrl,
    required this.pageUrl,
  });

  factory PageCard.fromPageItem(PageItem pageItem) {
    return PageCard(
      pageId: pageItem.pageId,
      title: pageItem.title,
      description: pageItem.description,
      exIntro: "",
      //TODO: pageItem.exIntro,
      imageUrl: pageItem.imageUrl,
      pageUrl: pageItem.pageUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = imageUrl.endsWith('.svg');
    const spacer = SizedBox(height: 16.0);
    const titleTextStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              // Add to favorites logic
              // Write your functionality here
            },
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
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              collapsed: Text(
                description,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: isSvg
                        ? SvgPicture.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            placeholderBuilder: (context) =>
                                ShimmerImage.withFixedHeight(),
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                ShimmerImage.withFixedHeight(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                  spacer,

                  // SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
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
                      gradient: LinearGradient(colors: [
                        Colors.pinkAccent.withOpacity(0.4),
                        Colors.deepOrange.withOpacity(0.4),
                      ], transform: GradientRotation(120)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.shade200,
                            offset: Offset(10, 5),
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
              child: Text('Open in browser'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PageCard(
      pageId: 2,
      title: "Title",
      description: "description",
      pageUrl: "pageUrl",
      imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
      exIntro:
          '<p class=\"mw-empty-elt\">\n</p>\n\n<p><b>Falcon 1</b> was a small-lift launch vehicle that was operated from 2006 to 2009 by SpaceX, an American aerospace manufacturer. On 28 September 2008, Falcon 1 became the first privately developed fully liquid-fueled launch vehicle to go into orbit around the Earth.<sup class=\"reference nowrap\"><span title=\"Page / location: 203\">: 203 </span></sup></p><p>The two-stage-to-orbit rocket used LOX/RP-1 for both stages, the first powered by a single Merlin engine and the second powered by a single Kestrel engine. It was designed by SpaceX from the ground up.\n</p><p>The vehicle was launched a total of five times. After three failed launch attempts, Falcon 1 achieved orbit on its fourth attempt in September 2008 with a mass simulator as a payload. On 14 July 2009, Falcon 1 made its second successful flight, delivering the Malaysian RazakSAT satellite to orbit on SpaceXs first commercial launch (fifth and final launch overall). Following this flight, the Falcon 1 was retired and succeeded by Falcon 9.\n</p><p>SpaceX had announced an enhanced variant, the Falcon 1e, but development was stopped in favor of Falcon 9.\n</p>',
    ),
  ));
}
