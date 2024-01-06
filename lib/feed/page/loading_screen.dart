import 'package:flutter/material.dart';
import 'package:stp/feed/page/shimmer.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Stack(
        alignment: Alignment.center,
        children: [ShimmerImage(), CircularProgressIndicator()],
      )),
    );
  }
}
