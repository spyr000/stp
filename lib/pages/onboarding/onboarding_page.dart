import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stp/data/dto/onboarding_item.dart';
import 'package:stp/pages/onboarding/onboarding_card.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _pageController = PageController();
  final _notifier = ValueNotifier<int>(0);

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
    OnboardingItem(
      imageUrl: 'assets/images/onboarding_image_6.jpg',
      description: 'Начните использовать наше приложение!',
    ),
  ];

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPageView(context),
          _buildStepIndicator(context),
          _buildLastPageButton(context),
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
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
          _notifier.value = index;
        },
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16.0),
      child: StepPageIndicator(
        stepColor: Theme.of(context).colorScheme.secondary,
        itemCount: ONBOARDING_ITEMS.length,
        currentPageNotifier: _notifier,
        size: 16,
        onPageSelected: (int index) {
          if (_notifier.value > index) {
            _pageController.jumpToPage(index);
          }
        },
      ),
    );
  }

  Widget _buildLastPageButton(BuildContext context) {
    return AnimatedBuilder(
      animation: _notifier,
      builder: (context, child) {
        bool isLastPage = _notifier.value == ONBOARDING_ITEMS.length - 1;
        return isLastPage
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () async {
                    _markOnboardingComplete().then((value) =>
                        Navigator.pushReplacementNamed(context, '/login'));
                  },
                  child: const Text('Приступить к использованию'),
                ),
              )
            : Container();
      },
    );
  }

  Future<void> _markOnboardingComplete() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingComplete', true);
  }
}
