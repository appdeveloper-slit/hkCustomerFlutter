import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/homedirectory/homeapi.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sidedrawer.dart';

List indexList = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext ctx;
  int _currentIndex = 0;
  String? userId;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  getSession() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      userId = sp.getString('user_id');
    });
    // ignore: use_build_context_synchronously
    homeApiAuth().homeApi(ctx, setState, [
      OneSignal.User.pushSubscription.id,
      sp.getString('user_id'),
      DateFormat('yyyy/MM/dd HH:mm:ss').format(DateTime.now()),
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DoubleBack(
      message: 'Press back again to exit😊😊',
      child: Scaffold(
        key: scaffoldState,
        backgroundColor: Theme.of(ctx).colorScheme.background,
        drawer: drawerLayout(
            ctx: ctx,
            scaffoldState: scaffoldState,
            setState: setState,
            userExits: userId),
        appBar: AppBar(
          backgroundColor: Theme.of(ctx).colorScheme.background,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              setState(() {
                scaffoldState.currentState!.openDrawer();
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: SvgPicture.asset(
                'assets/menu.svg',
                fit: BoxFit.fitWidth,
                color: Theme.of(ctx).colorScheme.primary == Clr().white
                    ? Clr().white
                    : Clr().primaryColor,
              ),
            ),
          ),
          title: Image.asset(
            'assets/applogo.png',
            height: Dim().d40,
            fit: BoxFit.contain,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d16),
              child: SvgPicture.asset(
                'assets/Group.svg',
                fit: BoxFit.fitWidth,
                color: Theme.of(ctx).colorScheme.primary == Clr().white
                    ? Clr().white
                    : Clr().primaryColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: Dim().d16),
              child: Icon(
                Icons.notifications_sharp,
                color: Theme.of(ctx).colorScheme.primary == Clr().white
                    ? Clr().white
                    : Clr().primaryColor,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: sliderList.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.network(
                          url['image_path'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildDots(),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              GridView.builder(
                itemCount: serviceArryList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GridItem(
                    name: serviceArryList[index]['name'],
                    image: serviceArryList[index]['image_path'],
                  );
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Container(
                height: Dim().d56,
                width: double.infinity,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                    color: Clr().white,
                    image: const DecorationImage(
                        image: AssetImage('assets/tips.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dim().d8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Health Tips',
                        style: poppinsSty().largeText.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      // ignore: prefer_const_constructors
                      IconButton(
                          onPressed: null,
                          // ignore: prefer_const_constructors
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.pink,
                            size: 20.0,
                            weight: 330.0,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Testmonials',
                  textAlign: TextAlign.center,
                  style: nunitaSty().mediumText.copyWith(
                        color: Theme.of(ctx).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              GridView.builder(
                itemCount: videoList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // ignore: prefer_const_constructors
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return videoItem(
                    video: videoList[index]['video_path'],
                    image: videoList[index]['image_path'],
                  );
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'FAQs',
                textAlign: TextAlign.center,
                style: nunitaSty().mediumText.copyWith(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              ListView.builder(
                itemCount: faqList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return faqWidget(
                    ans: faqList[index]['ans'],
                    qt: faqList[index]['que'],
                    index: index,
                  );
                },
              ),
              SizedBox(
                height: Dim().d12,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      STM().openWeb('https://www.hkwhcs.in/faqs');
                    });
                  },
                  child: Text(
                    'View All',
                    textAlign: TextAlign.center,
                    style: nunitaSty().mediumText.copyWith(
                          color: Theme.of(ctx).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < sliderList.length; i++) {
      dots.add(
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dim().d2, vertical: Dim().d8),
          child: Container(
            width: Dim().d8,
            height: Dim().d8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == i ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ),
      );
    }
    return dots;
  }
}

class GridItem extends StatelessWidget {
  final String name;
  final String image;

  GridItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Theme.of(context).colorScheme.background == Clr().background
          ? Clr().white
          : Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dim().d8))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.network(
            image,
            fit: BoxFit.cover,
            height: Dim().d40,
            width: Dim().d40,
          ),
          SizedBox(
            height: Dim().d12,
          ),
          Text(name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: nunitaSty().microText.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.primary,
                  )),
        ],
      ),
    );
  }
}

class videoItem extends StatelessWidget {
  final String video;
  final String image;

  videoItem({required this.video, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dim().d120,
      width: Dim().d200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
          image:
              DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
      child: Center(child: SvgPicture.asset('assets/play.svg')),
    );
  }
}

class faqWidget extends StatelessWidget {
  final qt, ans, index;
  const faqWidget({super.key, this.qt, this.ans, this.index});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Card(
          elevation: 1,
          color: Theme.of(context).colorScheme.background,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dim().d2))),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        qt,
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    indexList.contains(qt)
                        ? InkWell(
                            onTap: () {
                              if (indexList.contains(qt)) {
                                setState(() {
                                  indexList.remove(qt);
                                });
                              }
                            },
                            child: Icon(
                              Icons.keyboard_arrow_up_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                indexList.add(qt);
                              });
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                indexList.contains(qt)
                    ? Text(
                        ans,
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
