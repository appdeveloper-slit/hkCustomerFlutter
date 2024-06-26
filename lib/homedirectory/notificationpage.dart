// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk/auth/authapi.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/values/dimens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'homeapi.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  late BuildContext ctx;
  getSession()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      sp.setString('date', DateTime.now().toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        homeApiAuth().notificationAuthApi(ctx, setState);
        getSession();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
    onWillPop: ()async{
      STM().finishAffinity(ctx, Home());
      return false;
    },
      child: Scaffold(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(ctx).colorScheme.background,
          forceMaterialTransparency: true,
          elevation: 1,
          leading: InkWell(
            onTap: () {
              STM().finishAffinity(ctx, Home());
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(ctx).colorScheme.primary,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Notifications',
            style: nunitaSty().extraLargeText.copyWith(
                  color: Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dim().d16),
            child: Column(
              children: [
                SizedBox(
                  height: Dim().d20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notiList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Dim().d20),
                      child: Container(
                        padding: EdgeInsets.all(Dim().d12),
                        decoration: BoxDecoration(
                            color: Theme.of(ctx).colorScheme.background,
                            border: Border.all(
                              color: Colors.black26,
                              width: 0.3,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                                color: Colors.black26,
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${notiList[index]['title']}',
                              style: nunitaSty().mediumText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(ctx).colorScheme.primary,
                                  ),
                            ),
                            SizedBox(
                              height: Dim().d16,
                            ),
                            Text(
                              '${notiList[index]['message']}',
                              style: nunitaSty().smalltext.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(ctx).colorScheme.primary,
                                  ),
                            ),
                            SizedBox(
                              height: Dim().d12,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${notiList[index]['date_time']}',
                                style: nunitaSty().microText.copyWith(
                                      fontWeight: FontWeight.w200,
                                      color: Theme.of(ctx).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
    );
  }
}
