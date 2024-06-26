import 'package:carousel_slider/carousel_slider.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/auth/login.dart';
import 'package:hk/homedirectory/homeapi.dart';
import 'package:hk/homedirectory/videolayout.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pathology/selectLocationPage.dart';
import 'healthtips.dart';
import 'notificationpage.dart';
import 'servicesdetail.dart';
import 'sidedrawer.dart';
import 'wallet.dart';

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
      userId = sp.getString('userid');
      print(userId);
    });
    // ignore: use_build_context_synchronously
    homeApiAuth().homeApi(ctx, setState, [
      OneSignal.User.pushSubscription.id,
      sp.getString('userid'),
      sp.getString('date')
    ]);
  }

  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _refreshData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      homeApiAuth().homeApi(ctx, setState, [
        OneSignal.User.pushSubscription.id,
        sp.getString('userid'),
        sp.getString('date'),
      ]);
      _refreshController.refreshCompleted();
    });
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
          forceMaterialTransparency: true,
          backgroundColor: Theme.of(ctx).colorScheme.background == Clr().white
              ? Clr().white
              : Theme.of(ctx).colorScheme.background,
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
            InkWell(
              onTap: () {
                STM().redirect2page(ctx, const walletPage());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d16),
                child: SvgPicture.asset(
                  'assets/Group.svg',
                  fit: BoxFit.fitWidth,
                  color: Theme.of(ctx).colorScheme.primary == Clr().white
                      ? Clr().white
                      : Clr().primaryColor,
                ),
              ),
            ),
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    if (userId != null) {
                      STM().redirect2page(ctx, const notificationPage());
                    } else {
                      STM().redirect2page(ctx, const loginPage());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: Dim().d16),
                    child: Icon(
                      Icons.notifications_sharp,
                      color: Theme.of(ctx).colorScheme.primary == Clr().white
                          ? Clr().white
                          : Clr().primaryColor,
                    ),
                  ),
                ),

                checkNotification != '0'
                      ? Positioned(
                          bottom: 1,
                          right: 15,
                          child: Container(
                            height: Dim().d14,
                            width: Dim().d14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Clr().red,
                            ),
                            child: Center(
                              child: Text(
                                checkNotification ?? '0',
                                style: nunitaSty()
                                    .microText
                                    .copyWith(color: Clr().white,fontSize: Dim().d8),
                              ),
                            ),
                          ),
                        )
                      : Container(
                        height: 0,
                      )
              ],
            )
          ],
        ),
        body: SmartRefresher(
          onRefresh: _refreshData,
          controller: _refreshController,
          child: SingleChildScrollView(
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
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        serviceArryList[index]['name'] == 'Pathology'
                            ? userId != null
                                ? STM().redirect2page(ctx, const locationPage())
                                : STM().redirect2page(ctx, const loginPage())
                            : STM().redirect2page(
                                ctx,
                                servicesDetailsPage(
                                  data: serviceArryList[index],
                                ),
                              );
                      },
                      child: GridItem(
                        name: serviceArryList[index]['name'],
                        image: serviceArryList[index]['image_path'],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                InkWell(
                  onTap: () {
                    STM().redirect2page(
                      ctx,
                      const healthtipsPage(),
                    );
                  },
                  child: Container(
                    height: Dim().d56,
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Clr().white,
                        border: Border.all(
                          color: Colors.black26,
                          width: 0.6,
                        ),
                        image: const DecorationImage(
                          image: AssetImage('assets/tips.png'),
                          fit: BoxFit.fitWidth,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dim().d12),
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
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.pink,
                            size: 20.0,
                            weight: 330.0,
                          )
                        ],
                      ),
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.all(Radius.circular(Dim().d12)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            color: Colors.black12,
            offset: Offset(0, 1),
          )
        ],
      ),
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
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: nunitaSty().microText.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
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
    return InkWell(
      onTap: () {
        STM().redirect2page(
            context,
            VideossWidget(
              id: video,
            ));
      },
      child: Container(
        height: Dim().d120,
        width: Dim().d200,
        decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              // ignore: prefer_const_constructors
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 1,
              )
            ],
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Center(child: SvgPicture.asset('assets/play.svg')),
      ),
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
        return Container(
          margin: EdgeInsets.only(bottom: Dim().d12),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.all(Radius.circular(Dim().d12)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: Colors.black12,
                    offset: Offset(0, 1))
              ]),
          child: Padding(
            padding: EdgeInsets.all(Dim().d16),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (indexList.contains(qt)) {
                      setState(() {
                        indexList.remove(qt);
                      });
                    } else {
                      setState(() {
                        indexList.add(qt);
                      });
                    }
                  },
                  child: Row(
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
                          ? Icon(
                              Icons.keyboard_arrow_up_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    ],
                  ),
                ),
                indexList.contains(qt)
                    ? SizedBox(
                        height: Dim().d12,
                      )
                    : Container(),
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
