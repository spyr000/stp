import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stp/data/dto/onboarding_item.dart';

class OnboardingCard extends StatefulWidget {
  final OnboardingItem item;

  const OnboardingCard({Key? key, required this.item}) : super(key: key);

  @override
  _OnboardingCardState createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipRect(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaX: 3 * _animation.value,
                      sigmaY: 3 * _animation.value),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.asset(
                      widget.item.imageUrl,
                      fit: BoxFit.cover,
                      alignment: Alignment.lerp(
                            Alignment.centerLeft,
                            Alignment.centerRight,
                            _animation.value,
                          ) ??
                          Alignment.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Text(
          widget.item.description,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
