import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageImage extends StatelessWidget {
  final String imageUrl;
  final bool isSvg;

  PageImage({Key? key, required this.imageUrl})
      : isSvg = imageUrl.endsWith('.svg'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: 200.0,
          width: 200.0,
          child: Card(
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
                  height: 200.0,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imageUrl,
                  height: 200.0, // Adjust the height as needed
                  fit: BoxFit.cover,
                ),
                ),
              ),
        ));
  }
}
