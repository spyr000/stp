import 'package:flutter/material.dart';
import 'package:page_view_indicators/arrow_page_indicator.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stp/model/onboarding_item.dart';
import 'package:stp/pages/onboarding/onboarding_card.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() {
    return _OnboardingPageState();
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  bool _isFirstOpening = true;

  static final List<OnboardingItem> ONBOARDING_ITEMS = [
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_1.jpg',
      description: 'Научитесь читать!',
    ),
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_2.jpg',
      description: 'Станьте умными, как этот кот!',
    ),
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_3.jpg',
      description: 'И этот кот!',
    ),
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_4.jpg',
      description: 'Выйдите из депрессии!',
    ),
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_5.gif',
      description: 'Начните радоваться!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPageView(),
          _buildStepIndicator(),
        ],
      ),
    );
  }

  _buildPageView() {
    return Expanded(
      child: PageView.builder(
        itemCount: ONBOARDING_ITEMS.length,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: OnboardingCard(
              item: ONBOARDING_ITEMS[index % ONBOARDING_ITEMS.length],
            ),
          );
        },
        onPageChanged: (int index) {
          _currentPageNotifier.value = index;
        },
      ),
    );
  }

  _buildStepIndicator() {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16.0),
      child: StepPageIndicator(
        stepColor: Colors.deepOrange,
        itemCount: ONBOARDING_ITEMS.length,
        currentPageNotifier: _currentPageNotifier,
        size: 16,
        onPageSelected: (int index) {
          if (_currentPageNotifier.value > index) {
            _pageController.jumpToPage(index);
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stp/model/onboarding_item.dart';
// import 'package:stp/pages/onboarding/onboarding_card.dart';
//
// class OnboardingPage extends StatelessWidget {
//   static final List<OnboardingItem> ONBOARDING_ITEMS = [
//     OnboardingItem(
//       imageUrl: 'assets/images/onboarding_image_1.jpg',
//       description: 'Научитесь читать!',
//     ),
//     OnboardingItem(
//       imageUrl: 'assets/images/onboarding_image_2.jpg',
//       description: 'Станьте умными, как этот кот!',
//     ),
//     OnboardingItem(
//       imageUrl: 'assets/images/onboarding_image_3.jpg',
//       description: 'И этот кот!',
//     ),
//   ];
//
//   const OnboardingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView.builder(
//         itemCount: ONBOARDING_ITEMS.length,
//         itemBuilder: (context, index) {
//           return OnboardingCard(
//             item: ONBOARDING_ITEMS[index],
//             isLastPage: index == ONBOARDING_ITEMS.length - 1,
//           );
//         },
//       ),
//     );
//   }
// }
