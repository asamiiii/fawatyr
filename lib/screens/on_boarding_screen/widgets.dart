import 'package:elnemr_invoice/core/colors.dart';
import 'package:elnemr_invoice/data/data_source/local/shared_pref.dart';
import 'package:elnemr_invoice/screens/login&Reg/reg_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding/onboarding.dart';

late int index;

final onboardingPagesList = [
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: nemrYellow,
          border: Border.all(
            width: 0.0,
            color: nemrYellow,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 60.0,
                ),
                child: Image.asset('assets/images/bar-graph.png',
                    ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'سجل فواتيرك',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 30
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '.سجل الفواتير بدون الاستغناء عن فواتيرك الورقيه ',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 15
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: nemrYellow,
          border: Border.all(
            width: 0.0,
            color: nemrYellow,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 60.0,
                ),
                child: Image.asset('assets/images/business-strategy.png',
                    ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تابع حسابات زبائنك',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 30
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'يمكنك متابعة خطط دفع زبائنك بسهوله',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 15
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: nemrYellow,
          border: Border.all(
            width: 0.0,
            color: nemrYellow,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 45.0,
                  vertical: 60.0,
                ),
                child: Image.asset('assets/images/working.png',
                    ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'تابع سجلات الزبائن',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 30
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'يمكنك بسهوله معرفة تواريخ السداد والمبالغ المسدده والمبالغ المستحقه و اجمالي الديون',
                    style: GoogleFonts.notoKufiArabic(
                      color: whiteColor,
                      fontSize: 15
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ];


  Material skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }

        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }



    Material  signupButton(BuildContext context) {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          CashHelper.addIsOnBoarding(false);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen(),));
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Sign up',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }