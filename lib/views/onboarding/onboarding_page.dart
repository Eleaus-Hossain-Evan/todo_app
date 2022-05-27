import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/controller/shared_preference_controller.dart';
import 'package:todo_app/views/home/home_page.dart';
import 'package:todo_app/views/onboarding/intro_page_1.dart';
import 'package:todo_app/views/onboarding/intro_page_2.dart';
import 'package:todo_app/views/onboarding/intro_page_3.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final _pref = Get.find<KSharedPreference>();

  final PageController _pageController = PageController();

  RxBool isLastPage = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                isLastPage(index == 2);
              },
              children: const [
                IntroPage1(),
                IntroPage2(),
                IntroPage3(),
              ],
            ),
            Container(
              alignment: const Alignment(0, .75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => _pageController.jumpToPage(2),
                    child: const Text("Skip"),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                  ),
                  isLastPage.isTrue
                      ? InkWell(
                          onTap: () {
                            _pref.setBool(_pref.isNew, false);
                            Get.to(const HomePage());
                          },
                          child: const Text("Done"),
                        )
                      : InkWell(
                          onTap: () => _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          ),
                          child: const Text("Next"),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
