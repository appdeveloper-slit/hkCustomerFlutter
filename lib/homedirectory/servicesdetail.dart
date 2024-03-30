import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/homedirectory/homeapi.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/styles.dart';
import 'videolayout.dart';

class servicesDetailsPage extends StatefulWidget {
  final data;
  const servicesDetailsPage({super.key, this.data});

  @override
  State<servicesDetailsPage> createState() => _servicesDetailsPageState();
}

class _servicesDetailsPageState extends State<servicesDetailsPage> {
  late BuildContext ctx;
  var details;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    details = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return details == null
        ? Container(
            color: Clr().white,
            height: MediaQuery.of(ctx).size.height,
            child: Center(
              child: CircularProgressIndicator(
                color: Clr().primaryColor,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: Theme.of(ctx).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(ctx).colorScheme.background,
              elevation: 1,
              leading: InkWell(
                onTap: () {
                  STM().back2Previous(ctx);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(ctx).colorScheme.primary == Clr().black
                      ? Clr().primaryColor
                      : Theme.of(ctx).colorScheme.primary,
                ),
              ),
              centerTitle: true,
              title: Text(
                '${details['name']}',
                style: nunitaSty().extraLargeText.copyWith(
                      color: Theme.of(ctx).colorScheme.primary == Clr().black
                          ? Clr().primaryColor
                          : Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  imgeLayout(),
                  SizedBox(
                    height: Dim().d16,
                  ),
                  Container(
                    width: double.infinity,
                    color: Clr().grey.withOpacity(0.1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dim().d16, horizontal: Dim().d20),
                      child: Text(
                        '${details['name']}',
                        style: nunitaSty().extraLargeText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d16,
                  ),
                  Container(
                    width: double.infinity,
                    color: Theme.of(ctx).colorScheme.primary == Clr().white
                        ? Clr().grey.withOpacity(0.1)
                        : Clr().white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Dim().d16, horizontal: Dim().d20),
                      child: Text(
                        '${details['description']}',
                        style: nunitaSty().mediumText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d16,
                  ),
                  Container(
                      width: double.infinity,
                      color: Theme.of(ctx).colorScheme.primary == Clr().white
                          ? Clr().grey.withOpacity(0.1)
                          : Clr().white,
                      child: Center(
                          child:
                              FeatureGridView(features: details['features']))),
                  SizedBox(
                    height: Dim().d16,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dim().d16),
                    child: GridView.builder(
                      itemCount: details['video_array'].length,
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
                          video: details['video_array'][index]['video_path'],
                          image: details['video_array'][index]['image_path'],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dim().d20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: Dim().d12),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          backgroundColor: Clr().primaryColor,
                        ),
                        onPressed: () {
                          homeApiAuth()
                              .bookingrequest(ctx, setState, details['id']);
                        },
                        child: Text(
                          'Request Booking',
                          style: nunitaSty().mediumText.copyWith(
                              color: Clr().white, fontWeight: FontWeight.w400),
                        )),
                  )
                ],
              ),
            ),
          );
  }

  imgeLayout() {
    if (details['slider_array'].length > 1) {
      return Column(
        children: [
          SizedBox(
            height: Dim().d12,
          ),
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
            items: details['slider_array'].map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(Dim().d12),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dim().d12)),
                      child: Image.network(
                        url['image_path'],
                        fit: BoxFit.cover,
                      ),
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
        ],
      );
    } else if (details['slider_array'].length == 1) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(Dim().d12),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Dim().d12)),
          child: Image.network(
            details['slider_array'][0]['image_path'],
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < details['slider_array'].length; i++) {
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

class FeatureGridView extends StatelessWidget {
  final List<dynamic> features;

  FeatureGridView({required this.features});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 80.0),
      itemCount: features.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dim().d12, vertical: Dim().d12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 15,
                color: Clr().primaryColor,
              ),
              SizedBox(
                width: Dim().d12,
              ),
              Expanded(
                child: Text(
                  '${features[index]['feature']!}',
                  style: nunitaSty().microText.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ),
            ],
          ),
        );
      },
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
            image: DecorationImage(
                image: NetworkImage(image), fit: BoxFit.fitHeight)),
        child: Center(child: SvgPicture.asset('assets/play.svg')),
      ),
    );
  }
}
