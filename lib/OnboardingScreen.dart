import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_page_new/on_boarding_model.dart';
import 'package:recipe_page_new/select_AllergiesDiets_Page.dart';

class Onboardingscreen extends StatefulWidget {
  const Onboardingscreen({super.key});

  @override
  State<Onboardingscreen> createState() =>
      _OnboardingscreenState();
}

class _OnboardingscreenState extends State<Onboardingscreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: ArcPaint(),
            child: SizedBox(
              height: size.height / 1.35,
              width: size.width,
            ),
          ),
          // for lottie animation file
          Positioned(
            top: 200,
            right: 0,
            left: 0,
            child: Lottie.asset(onboardintItems[currentIndex].lottieURL,
                width: 500, alignment: Alignment.topCenter),
          ),
          // for scrolling
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: onboardintItems.length,
                      itemBuilder: (context, index) {
                        final items = onboardintItems[index];
                        return Column(
                          children: [
                            Text(
                              items.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              items.subtitle,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                    ),
                  ),
                  // dot indicator
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0;
                          index < onboardintItems.length;
                          index++)
                        dotIndicator(isSelected: index == currentIndex),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: currentIndex < 4
        ? FloatingActionButton(
            onPressed: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linear,
              );
            },
            elevation: 0,
            backgroundColor: Colors.white,
            child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
          )
        : FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectAllergiesdietsPage()));
            },
            elevation: 0,
            backgroundColor: Colors.lightGreen,
            child: const Text('Start'),
          ),
    );
  }

  Widget dotIndicator({required bool isSelected}) {
    return Padding(
      padding: const EdgeInsets.only(right: 7),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        height: isSelected ? 8 : 6,
        width: isSelected ? 8 : 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.lightGreen : Colors.black26,
        ),
      ),
    );
  }
}

class ArcPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path orangeArc = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height - 175)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 175)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(orangeArc, Paint()..color = Colors.lightGreen);

    Path whiteArc = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height - 180)
      ..quadraticBezierTo(
          size.width / 2, size.height - 60, size.width, size.height - 180)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(
      whiteArc,
      Paint()..color = const Color.fromARGB(255, 144, 202, 249),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}