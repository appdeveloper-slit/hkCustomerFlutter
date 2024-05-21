import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../manage/static_method.dart';
import '../requests/requetauth.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/styles.dart';
import 'detailspage.dart';

class pathorequestPage extends StatefulWidget {
  const pathorequestPage({super.key});

  @override
  State<pathorequestPage> createState() => _pathorequestPageState();
}

class _pathorequestPageState extends State<pathorequestPage> {
  late BuildContext ctx;
  // ignore: prefer_final_fields

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      requestAuthApi().getpathologyrequest(ctx, setState);
      _refreshController.refreshCompleted();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        requestAuthApi().getpathologyrequest(ctx, setState);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        STM().finishAffinity(ctx, Home());
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        appBar: AppBar(
          elevation: 2,
          shadowColor: Clr().black,
          backgroundColor: Theme.of(ctx).colorScheme.background,
          leading: InkWell(
            onTap: () {
              STM().finishAffinity(ctx, Home());
            },
            child: Icon(
              Icons.arrow_back,
              color: Theme.of(ctx).colorScheme.primary == Clr().black
                  ? Clr().primaryColor
                  : Theme.of(ctx).colorScheme.primary,
            ),
          ),
          title: Text(
            'Pathology Request',
            style: nunitaSty().extraLargeText.copyWith(
                  color: Theme.of(ctx).colorScheme.primary == Clr().black
                      ? Clr().primaryColor
                      : Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          centerTitle: true,
        ),
        body: SmartRefresher(
          onRefresh: _refreshData,
          controller: _refreshController,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Dim().d20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dim().d16),
                  child: ListView.builder(
                    itemCount: pathologyRequestList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: Dim().d16),
                        child: InkWell(
                          onTap: () {
                            STM().redirect2page(
                                ctx,
                                detailspage(
                                  data: pathologyRequestList[index],
                                  bookingid: pathologyRequestList[index]
                                      ['booking_id'],
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(ctx).colorScheme.background,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(Dim().d12)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: Dim().d2,
                                  color: Colors.black12,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dim().d14, horizontal: Dim().d32),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${pathologyRequestList[index]['package_details'][0]['test_name']}',
                                        style: nunitaSty().mediumText.copyWith(
                                              color: Theme.of(ctx)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      // SizedBox(
                                      //   height: Dim().d4,
                                      // ),
                                      // Text(
                                      //   pathologyRequestList[index]
                                      //               ['is_cancel'] ==
                                      //           true
                                      //       ? "Cancelled"
                                      //       : '${pathologyRequestList[index]['booking_status']}',
                                      //   style: nunitaSty().smalltext.copyWith(
                                      //         color: pathologyRequestList[index]
                                      //                     ['is_cancel'] ==
                                      //                 true
                                      //             ? Clr().errorRed
                                      //             : pathologyRequestList[index][
                                      //                         'booking_status'] ==
                                      //                     'Pending'
                                      //                 ? Clr().yellow
                                      //                 : pathologyRequestList[
                                      //                                 index][
                                      //                             'booking_status'] ==
                                      //                         'Completed'
                                      //                     ? Clr().successGreen
                                      //                     : Theme.of(ctx)
                                      //                         .colorScheme
                                      //                         .primary,
                                      //         fontWeight: FontWeight.w400,
                                      //       ),
                                      // ),
                                      SizedBox(
                                        height: Dim().d4,
                                      ),
                                      pathologyRequestList[index]
                                                  ['booking_date'] ==
                                              null
                                          ? Container()
                                          : Text(
                                              DateFormat('dd MMM yyyy').format(
                                                  DateTime.parse(
                                                      pathologyRequestList[
                                                                  index]
                                                              ['booking_date']
                                                          .toString())),
                                              style: nunitaSty()
                                                  .microText
                                                  .copyWith(
                                                    color: Theme.of(ctx)
                                                                .colorScheme
                                                                .primary ==
                                                            Clr().black
                                                        ? Color(0xffB4A7A7)
                                                        : Theme.of(ctx)
                                                            .colorScheme
                                                            .primary,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
