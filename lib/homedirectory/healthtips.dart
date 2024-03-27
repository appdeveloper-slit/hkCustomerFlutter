import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk/homedirectory/homeapi.dart';
import 'package:hk/values/dimens.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';

class healthtipsPage extends StatefulWidget {
  const healthtipsPage({super.key});

  @override
  State<healthtipsPage> createState() => _healthtipsPageState();
}

class _healthtipsPageState extends State<healthtipsPage> {
  late BuildContext ctx;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  int selectIndex = -1;

  @override
  Widget build(BuildContext context) {
    ctx = context;

    return Scaffold(
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
            color: Theme.of(ctx).colorScheme.primary == Clr().background
                ? Clr().primaryColor
                : Theme.of(ctx).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Health Tips',
          style: nunitaSty().smalltext.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().background
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
        child: Column(
          children: [
            SizedBox(
              height: Dim().d12,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tipsList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  color: Theme.of(ctx).colorScheme.background,
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d12),
                    child: Column(
                      children: [
                        Text(
                          '${tipsList[index]['description']}',
                          maxLines: selectIndex != index ? 3 : null,
                          style: nunitaSty().smalltext.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        InkWell(
                          onTap: () {
                            if (selectIndex == index) {
                              setState(() {
                                selectIndex = -1;
                              });
                            } else {
                              setState(() {
                                selectIndex = index;
                              });
                            }
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              selectIndex != index ? 'readmore' : 'readless',
                              style: nunitaSty().microText.copyWith(
                                    color: Clr().blue,
                                    fontWeight: FontWeight.w100,
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dim().d20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${tipsList[index]['date']}',
                            style: nunitaSty().microText.copyWith(
                                  color: Clr().black.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
