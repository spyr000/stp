import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImage extends StatelessWidget {
  final double? height;
  final double? width;

  factory ShimmerImage.withFixedHeight({Key? key}) {
    return ShimmerImage(
      key: key,
      height: 200.0,
    );
  }

  const ShimmerImage({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.pinkAccent,
      highlightColor: Colors.deepOrange,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        color: Colors.white,
      ),
    );
  }
}
