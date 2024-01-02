import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stp/feed/page/page_item.dart';

class PageCard extends StatelessWidget {
  final String title;
  final String description;
  final String exIntro;
  final String imageUrl;
  final String pageUrl;
  final bool isSvg;

  const PageCard(
      {super.key,
      required this.title,
      required this.description,
      required this.exIntro,
      required this.imageUrl,
      required this.pageUrl,
      required this.isSvg});

  factory PageCard.fromPageItem(PageItem pageItem) {
    return PageCard(
        title: pageItem.title,
        description: pageItem.description,
        exIntro: "",
        //TODO: pageItem.exIntro,
        imageUrl: pageItem.imageUrl,
        pageUrl: pageItem.pageUrl,
        isSvg: pageItem.imageUrl.endsWith('.svg'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the HomeScreen
            // Write your navigation logic here
          },
        ),
        title: Text(
          'Wikipedia Page Title',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
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
            isSvg
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
            SizedBox(height: 16.0),
            Text(
              'Wikipedia Page Title',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Description text goes here...',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Html(
                  data:
                      '<p class=\"mw-empty-elt\">\n</p>\n\n<p><b>Falcon 1</b> was a small-lift launch vehicle that was operated from 2006 to 2009 by SpaceX, an American aerospace manufacturer. On 28 September 2008, Falcon 1 became the first privately developed fully liquid-fueled launch vehicle to go into orbit around the Earth.<sup class=\"reference nowrap\"><span title=\"Page / location: 203\">: 203 </span></sup></p><p>The two-stage-to-orbit rocket used LOX/RP-1 for both stages, the first powered by a single Merlin engine and the second powered by a single Kestrel engine. It was designed by SpaceX from the ground up.\n</p><p>The vehicle was launched a total of five times. After three failed launch attempts, Falcon 1 achieved orbit on its fourth attempt in September 2008 with a mass simulator as a payload. On 14 July 2009, Falcon 1 made its second successful flight, delivering the Malaysian RazakSAT satellite to orbit on SpaceXs first commercial launch (fifth and final launch overall). Following this flight, the Falcon 1 was retired and succeeded by Falcon 9.\n</p><p>SpaceX had announced an enhanced variant, the Falcon 1e, but development was stopped in favor of Falcon 9.\n</p>',
                  style: {
                    "p": Style(fontSize: FontSize(16.0)),
                    // Define styles for other HTML tags as needed
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Open in browser logic
                // Write your functionality here
              },
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
        title: "Title",
        description: "description",
        pageUrl: "pageUrl",
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/c/c8/Falcon_1_Flight_4_liftoff.jpg",
        exIntro: "escs",
        isSvg: false),
  ));
}
