import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/screens/on_boarding_screen/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:onboarding/onboarding.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;

  @override
  void initState() {
    super.initState();
    materialButton = skipButton();
    index=0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:nemrYellow ,
       body: Onboarding(
        pages: onboardingPagesList,
        onPageChange: (pageIndex) {
          index = pageIndex;
        },
        startPageIndex: 0,
        footerBuilder: (context, netDragDistance, pagesLength, setIndex) {
          return DecoratedBox(
              decoration: BoxDecoration(
                color: background,
                border: Border.all(
                  width: 0.0,
                  color: background,
                ),
              ),
              child: ColoredBox(
                color: background,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIndicator(
                        netDragPercent: netDragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          indicatorDesign: IndicatorDesign.line(
                            lineDesign: LineDesign(
                              lineType: DesignType.line_uniform,
                            ),
                          ),
                        ),
                      ),
                      index == pagesLength - 1
                          ? signupButton(context)
                          : skipButton(setIndex: setIndex)
                    ],
                  ),
                ),
              ),
            );
        },
       ),
    );
  }
}