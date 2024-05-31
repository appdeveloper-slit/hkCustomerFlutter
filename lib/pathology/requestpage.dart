// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool checkLoader = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List requestList = [];

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      requestAuthApi().getpathologyrequest(ctx, setState);
      _refreshController.refreshCompleted();
    });
  }

  var bookingstatus;
  var bookingdescription;

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(
    //   Duration.zero,
    //   () {
    //     requestAuthApi().getpathologyrequest(ctx, setState);
    //   },
    // );
    Future.delayed(Duration.zero, () {
      getTokken();
    });
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
          surfaceTintColor: Clr().transparent,
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
                                      SizedBox(
                                        height: Dim().d4,
                                      ),
                                      if (requestList.isNotEmpty)
                                        Text(
                                          requestList[index],
                                          style: nunitaSty().smalltext.copyWith(
                                                color: Clr().primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
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

  void getTokken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = await STM().pathologyApi(
      apiname: 'getAccessToken',
      type: 'get',
      ctx: ctx,
      load: true,
      loadtitle: 'Fetching Token...',
    );
    if (result['success'] == true) {
      setState(() {
        print(result['access_token']);
        sp.setString('pathotoken', result['access_token']);
        getpathologyrequest(ctx, setState);
      });
    } else {
      setState(() {
        checkLoader = false;
      });
      STM().errorDialogWithinffinity(ctx, result['message'], const Home());
    }
  }

  void getpathologyrequest(ctx, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'customer_id': sp.getString('userid'),
    };
    print(body);
    var result = await STM().allApi(
      apiname: 'my_requests',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading...',
      type: 'post',
    );
    if (result['success']) {
      setState(() {
        pathologyRequestList = result['data'];
      });
      for (int a = 0; a < pathologyRequestList.length; a++) {
        setState(() {
          getbookingstatus(id: pathologyRequestList[a]['booking_id']);
        });
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  getbookingstatus({id}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    requestList.clear();
    var body = {
      "booking_id": id,
    };
    var result = await STM().pathologyApi(
      apiname: 'getBookingStatus',
      body: body,
      ctx: ctx,
      type: 'post',
      token: sp.getString('pathotoken'),
    );
    if (result['status'] == true) {
      switch (result['data']['booking_status']) {
        case "BS002":
          setState(() {
            bookingstatus = 'Order Booked';
            bookingdescription = "Order Booked";
            requestList.add(bookingstatus);
          });
          break;
        case "BS003":
          setState(() {
            bookingstatus = 'Cancelled';
            bookingdescription = "Order Cancelled";
            requestList.add(bookingstatus);
          });
          break;
        case "BS005":
          setState(() {
            bookingstatus = 'Pickup Scheduled';
            bookingdescription = "Booking is verified";
            requestList.add(bookingstatus);
          });
          break;
        case "BS006":
          setState(() {
            bookingstatus = 'Sample Collector Reached Home';
            bookingdescription = "Sample Collector Reached Home";
            requestList.add(bookingstatus);
          });
          break;
        case "BS007":
          setState(() {
            bookingstatus = 'Sample Collected';
            bookingdescription = "Sample Collected";
            requestList.add(bookingstatus);
          });
          break;
        case "BS008":
          setState(() {
            bookingstatus = 'Sample Received at Lab';
            bookingdescription = "Sample Received at Lab";
            requestList.add(bookingstatus);
          });
          break;
        case "BS009":
          setState(() {
            bookingstatus = 'Report Generated';
            bookingdescription =
                "Report Generated from the Lab but pending for verification";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0012":
          setState(() {
            bookingstatus = 'Health Counselling';
            bookingdescription = "Doctor Consultation Done";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0013":
          setState(() {
            bookingstatus = 'Rescheduled';
            bookingdescription = "Booking Reschedule";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0015":
          setState(() {
            bookingstatus = 'Report Available';
            bookingdescription = "Report is available and send to customer";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0018":
          setState(() {
            bookingstatus = 'Resampling Process Initiated';
            bookingdescription = "Resampling Process Initiated";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0021":
          setState(() {
            bookingstatus = 'Missed Doctor Consultation';
            bookingdescription = "Doctor Consultation Call Missed";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0023":
          setState(() {
            bookingstatus = 'Reject Sample';
            bookingdescription = "Sample got Reject due to some reason";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0026":
          setState(() {
            bookingstatus = "Sample Collector's Call Not Picked";
            bookingdescription = "Sample Collector's Call Not Picked";
            requestList.add(bookingstatus);
          });
          break;
        case "BS0027":
          setState(() {
            bookingstatus = "Payment issue - hold";
            bookingdescription = "Booking is on-hold due to Payment Issue";
            requestList.add(bookingstatus);
          });
          break;
        default:
          setState(() {
            checkLoader = false;
          });
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
    print(requestList);
  }
}
