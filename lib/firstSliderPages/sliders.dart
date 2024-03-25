// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/login.dart';
import '../manage/static_method.dart';

class sliders extends StatefulWidget {
  const sliders({super.key});

  @override
  State<sliders> createState() => _slidersState();
}

class _slidersState extends State<sliders> {
  late BuildContext ctx;
  int _selectIndex = 0;
  PageController controller = PageController();
  List<Map<String, dynamic>> pageList = [
    {
      'image': 'assets/step1.png',
      'image2': 'assets/smallstep1.svg',
      'text': 'Care Where You Are',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dictum elementum pellentesque at vitae ut lacus,',
    },
    {
      'image': 'assets/step2.png',
      'image2': 'assets/small_step2.svg',
      'text': 'Get Personal Care Nursing And Other Services',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dictum elementum pellentesque at vitae ut lacus,',
    },
    {
      'image': 'assets/step3.png',
      'image2': 'assets/small_step3.svg',
      'text': 'Create Personalised CarePlans',
      'subtitle':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Dictum elementum pellentesque at vitae ut lacus,',
    },
  ];

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        body: Column(
          children: [
            SizedBox(height: Dim().d52,),
                   GestureDetector(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                if (_selectIndex == 2) {
                  setState(() {
                    sp.setBool('firstpage', true);
                    STM().redirect2page(ctx, loginPage());
                  });
                }
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _selectIndex == 2 ? 'Next' : 'Skip',
                    style: nunitaSty().smalltext.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  SvgPicture.asset(
                    'assets/arrow_right.svg',
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
                  SizedBox(
                    width: Dim().d20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 500.0,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int index) {
                    setState(() {
                      _selectIndex = index;
                    });
                    print(_selectIndex);
                  },
                  itemCount: pageList.length,
                  itemBuilder: (context, index) {
                    return sliderPage(index, pageList[index]);
                  },
                ),
              ),
            ),
            SmoothPageIndicator(
          controller: controller,
          count: pageList.length,
          effect: ExpandingDotsEffect(
              dotHeight: 8.0,
              dotWidth: 8.0,
              dotColor: Clr().hintColor.withOpacity(0.4),
              activeDotColor: Clr().primaryColor,
              expansionFactor: 3.0,
              spacing: 2.0),
        ),
        SizedBox(height: Dim().d120,),
          ],
        ));
  }

  Widget sliderPage(index, list) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Dim().d40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Image.asset(
            list['image'],
            fit: BoxFit.contain,
            height: Dim().d340,
            alignment: Alignment.center,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: Dim().d52,
        ),
        Text(
          list['text'],
          textAlign: TextAlign.center,
          style: nunitaSty().extraLargeText.copyWith(
              color: Clr().primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 22.0),
        ),
        SizedBox(
          height: Dim().d20,
        ),
        Expanded(
          child: Text(
            list['subtitle'],
            textAlign: TextAlign.center,
            style: nunitaSty().microText.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(ctx).colorScheme.primary,
                ),
          ),
        ),
      
      ],
    );
  }
}
