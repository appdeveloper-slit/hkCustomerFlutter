import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hk/values/dimens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timelines/timelines.dart';
import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'cancelrequest.dart';
import 'requetauth.dart';

final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
final GlobalKey<TooltipState> tooltipkey1 = GlobalKey<TooltipState>();

class requestdetailPage extends StatefulWidget {
  final data;
  const requestdetailPage({
    super.key,
    this.data,
  });

  @override
  State<requestdetailPage> createState() => _requestdetailPageState();
}

class _requestdetailPageState extends State<requestdetailPage> {
  late BuildContext ctx;

  int activeStep = 0;
  double progress = 0.2;
  List nameList = [
    'Booked on',
    'Accepted on',
    'Partner assigned',
    'In Progress',
    'Completed',
    'Billed',
  ];

  List progressStList = [
    'Pending',
    'Accepted',
    'Partner Assigned',
    'In Progress',
    'Completed',
    'Billed',
  ];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        // requestAuthApi().getallRequest(ctx, setState, id: widget.data['id']);
        requestAuthApi().bookingDetails(ctx, setState, widget.data['id']);
      },
    );
    super.initState();
  }

  // ignore: prefer_final_fields
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      // requestAuthApi().getallRequest(ctx, setState, id: widget.data['id']);
      requestAuthApi().bookingDetails(ctx, setState, widget.data['id']);
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return bookingdetails == null
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
                '${widget.data['service']}',
                style: nunitaSty().extraLargeText.copyWith(
                      color: Theme.of(ctx).colorScheme.primary == Clr().black
                          ? Clr().primaryColor
                          : Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            body: SmartRefresher(
              controller: _refreshController,
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dim().d12,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.data['is_cancel'] == true
                            ? 'Cancelled'
                            : statusList.last == 'booked_on'
                                ? 'Pending'
                                : statusList.last == 'accepted_on'
                                    ? 'Accepted'
                                    : statusList.last == 'assign_on'
                                        ? 'Partner Assign'
                                        : statusList.last == 'progress_on'
                                            ? 'In Progress'
                                            : statusList.last == 'completed_on'
                                                ? 'Completed'
                                                : 'Billded',
                        style: nunitaSty().extraLargeText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Dim().d12,
                    ),
                    statusList.last == 'booked_on'
                        ? Text(
                            'Our executives will contact you soon to understand your requirement',
                            textAlign: TextAlign.center,
                            style: nunitaSty().mediumText.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                          )
                        : statusList.last == 'accepted_on'
                            ? Text(
                                'Your request has been accepted, we are searching a suitable partner for you',
                                textAlign: TextAlign.center,
                                style: nunitaSty().mediumText.copyWith(
                                      color: Theme.of(ctx).colorScheme.primary,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            : Container(),

                    /// partner details
                    if (bookingdetails['partner_name'] != "")
                      Column(
                        children: [
                          SizedBox(
                            height: Dim().d20,
                          ),
                          partnerLayout(),
                        ],
                      ),

                    /// pay via wallet button and final cost and final duration container
                    if (statusList.last == 'completed_on')
                      Column(
                        children: [
                          walletLayout(),
                        ],
                      ),

                    /// start otp and complete otp and getotp
                    if (statusList.last == 'assign_on' ||
                        statusList.last == 'progress_on')
                      Column(
                        children: [
                          SizedBox(
                            height: Dim().d12,
                          ),
                          getotpLayout(),
                        ],
                      ),

                    /// partner attendance
                    if (bookingdetails['partner_attendence'].isNotEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: Dim().d12,
                          ),
                          partnerAttendanceLayout(),
                        ],
                      ),
                    SizedBox(
                      height: Dim().d12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dim().d14),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Theme.of(ctx).colorScheme.background,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: Dim().d2,
                                color: Colors.black12,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: Dim().d20),
                          child: FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                              indicatorTheme: IndicatorThemeData(
                                size: Dim().d14,
                                position: -1,
                              ),
                              color: Colors.pink,
                              connectorTheme: ConnectorThemeData(
                                color: Clr().grey.withOpacity(0.4),
                                thickness: 3.0,
                                indent: 0.0,
                              ),
                            ),
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            builder: TimelineTileBuilder.connected(
                              oppositeContentsBuilder: (context, index) =>
                                  Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        (bookingdetails['track_array'].length -
                                                    1) ==
                                                index
                                            ? Dim().d0
                                            : Dim().d40,
                                    left: Dim().d20),
                                child: Text(
                                    '${bookingdetails['track_array'][index]['date']}',
                                    style: nunitaSty().smalltext.copyWith(
                                        color:
                                            Theme.of(ctx).colorScheme.primary,
                                        fontWeight: FontWeight.w400)),
                              ),
                              contentsBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        (bookingdetails['track_array'].length -
                                                    1) ==
                                                index
                                            ? Dim().d0
                                            : Dim().d40,
                                    left: Dim().d20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('${nameList[index]}',
                                          textAlign: TextAlign.start,
                                          style: nunitaSty().smalltext.copyWith(
                                              color: Theme.of(ctx)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                ),
                              ),
                              contentsAlign: ContentsAlign.reverse,
                              indicatorBuilder: (context, index) =>
                                  Indicator.dot(),
                              connectorBuilder: (context, index, type) =>
                                  Connector.solidLine(
                                color: bookingdetails['track_array'][index]
                                            ['date'] ==
                                        ""
                                    ? Clr().grey.withOpacity(0.5)
                                    : Colors.pink,
                                thickness: 2,
                                direction: Axis.vertical,
                              ),
                              connectionDirection: ConnectionDirection.before,
                              indicatorPositionBuilder: (context, index) => 0.0,
                              itemCount: bookingdetails['track_array'].length,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dim().d28,
                    ),
                    statusList.last == 'completed_on' ||
                            widget.data['is_cancel'] == true ||
                            statusList.last == 'billed_on'
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dim().d20,
                            ),
                            child: SizedBox(
                              height: Dim().d44,
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Clr().primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Dim().d2),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Clr().white,
                                          elevation: 0,
                                          insetPadding:
                                              EdgeInsets.all(Dim().d4),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(Dim().d12))),
                                          title: SvgPicture.asset(
                                            'assets/cancel.svg',
                                            height: Dim().d120,
                                            fit: BoxFit.contain,
                                          ),
                                          content: Text(
                                            'Are you sure you want to Cancel?',
                                            style: nunitaSty().smalltext,
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: Dim().d44,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Clr()
                                                                        .primaryColor,
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .zero,
                                                                )),
                                                        onPressed: () {
                                                          STM().redirect2page(
                                                              ctx,
                                                              cancelRequest(
                                                                id: bookingdetails[
                                                                    'id'],
                                                              ));
                                                        },
                                                        child: Text(
                                                          'Proceed',
                                                          style: nunitaSty()
                                                              .smalltext
                                                              .copyWith(
                                                                color:
                                                                    Clr().white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dim().d12,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: Dim().d44,
                                                    child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Clr().white,
                                                          elevation: 0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  side:
                                                                      BorderSide(
                                                            color: Clr()
                                                                .primaryColor,
                                                            width: 1.5,
                                                          )),
                                                        ),
                                                        onPressed: () {
                                                          STM().back2Previous(
                                                              ctx);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: nunitaSty()
                                                              .smalltext
                                                              .copyWith(
                                                                color: Clr()
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: nunitaSty().mediumText.copyWith(
                                          color: Clr().white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )),
                            ),
                          ),
                    SizedBox(
                      height: Dim().d28,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget partnerAttendanceLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dim().d14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.background,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: Dim().d2,
                color: Colors.black12,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Dim().d14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dim().d12, bottom: Dim().d12),
                  child: SvgPicture.asset(
                    'assets/attd.svg',
                    height: Dim().d24,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: Dim().d12,
                ),
                Text(
                  'Partner Attendance',
                  style: nunitaSty().smalltext.copyWith(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Divider(
              color: Clr().grey.withOpacity(0.2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dim().d8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Sign in',
                    style: nunitaSty().mediumText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  Text(
                    'Sign out',
                    style: nunitaSty().mediumText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Clr().grey.withOpacity(0.2),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingdetails['partner_attendence'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Dim().d12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        bookingdetails['partner_attendence'][index]
                            ['start_date'],
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                      Text(
                        bookingdetails['partner_attendence'][index]
                            ['completed_date'],
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: Dim().d12,
            ),
          ],
        ),
      ),
    );
  }

  Widget getotpLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dim().d14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.background,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: Dim().d2,
                color: Colors.black12,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(Dim().d14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Start OTP ',
                        style: nunitaSty().smalltext.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      Tooltip(
                        message:
                            'Start OTP,Share this OTP with the partner\n each time,to start the service',
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Clr().grey,
                        ),
                        key: tooltipkey,
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        preferBelow: false,
                        textStyle: nunitaSty().mediumText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().white,
                            ),
                        showDuration: const Duration(seconds: 2),
                        waitDuration: const Duration(seconds: 1),
                      ),
                      InkWell(
                        onTap: () {
                          tooltipkey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 18.0,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Row(
                    children: [
                      Text(
                        'Complete OTP ',
                        style: nunitaSty().smalltext.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      Tooltip(
                        message:
                            'Complete OTP: Share this OTP with the partner each time,to complete or end the service',
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Clr().grey,
                        ),
                        key: tooltipkey1,
                        height: 50,
                        padding: const EdgeInsets.all(8.0),
                        preferBelow: false,
                        textStyle: nunitaSty().mediumText.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().white,
                            ),
                        showDuration: const Duration(seconds: 2),
                        waitDuration: const Duration(seconds: 1),
                      ),
                      InkWell(
                        onTap: () {
                          tooltipkey1.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 18.0,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    ':',
                    style: nunitaSty().smalltext.copyWith(
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Text(
                    ':',
                    style: nunitaSty().smalltext.copyWith(
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  bookingdetails['start_otp'] == ""
                      ? SizedBox(
                          height: Dim().d24,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                  Dim().d8,
                                ))),
                                backgroundColor: Clr().green,
                              ),
                              onPressed: () {
                                requestAuthApi().getOTP(ctx, setState, 'start',
                                    bookingdetails['id']);
                              },
                              child: Text(
                                'Get OTP',
                                style: nunitaSty().smalltext.copyWith(
                                      color: Clr().white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )),
                        )
                      : Text(
                          '${bookingdetails['start_otp']}',
                          style: nunitaSty().smalltext.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  bookingdetails['complete_otp'] == ""
                      ? SizedBox(
                          height: Dim().d24,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                  Dim().d8,
                                ))),
                                backgroundColor: Clr().green,
                              ),
                              onPressed: () {
                                requestAuthApi().getOTP(ctx, setState,
                                    'complete', bookingdetails['id']);
                              },
                              child: Text(
                                'Get OTP',
                                style: nunitaSty().smalltext.copyWith(
                                      color: Clr().white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )),
                        )
                      : Text(
                          '${bookingdetails['complete_otp']}',
                          style: nunitaSty().smalltext.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget walletLayout() {
    return Column(
      children: [
        SizedBox(
          height: Dim().d12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d14),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: Dim().d2,
                    color: Colors.black12,
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: Dim().d14,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: Dim().d12, bottom: Dim().d12),
                      child: SvgPicture.asset(
                        'assets/hand.svg',
                        height: Dim().d24,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: Dim().d12,
                    ),
                    Text(
                      'Summary',
                      style: nunitaSty().smalltext.copyWith(
                          color: Theme.of(ctx).colorScheme.primary,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                Divider(
                  color: Clr().grey.withOpacity(0.2),
                ),
                Padding(
                  padding: EdgeInsets.all(Dim().d14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Final Cost',
                                style: nunitaSty().smalltext.copyWith(
                                      color: Theme.of(ctx).colorScheme.primary,
                                      fontWeight: FontWeight.w300,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Text(
                            'Final Duration ',
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            ':',
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                ),
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Text(
                            ':',
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '₹${bookingdetails['est_cost']}',
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          SizedBox(
                            height: Dim().d12,
                          ),
                          Text(
                            '${bookingdetails['est_duration']}',
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Dim().d12,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: SizedBox(
            height: Dim().d48,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Clr().primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                onPressed: () {
                  requestAuthApi().paymentApi(ctx, setState,
                      bookingdetails['id'], bookingdetails['est_cost']);
                },
                child: Text(
                  'Pay Via Wallet',
                  style: nunitaSty().mediumText.copyWith(
                        color: Clr().white,
                        fontWeight: FontWeight.w400,
                      ),
                )),
          ),
        ),
      ],
    );
  }

  Widget partnerLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dim().d14),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.background,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: Dim().d2,
                color: Colors.black12,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: Dim().d14,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Dim().d12, bottom: Dim().d12),
                  child: SvgPicture.asset(
                    'assets/hand.svg',
                    height: Dim().d24,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: Dim().d12,
                ),
                Text(
                  'Partner Details',
                  style: nunitaSty().smalltext.copyWith(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Divider(
              color: Clr().grey.withOpacity(0.2),
            ),
            Row(
              children: [
                SizedBox(
                  width: Dim().d12,
                ),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Clr().white,
                          width: 0.3,
                        )),
                    child: STM().networkimg(bookingdetails['profile_img'])),
                SizedBox(
                  width: Dim().d12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookingdetails['partner_name'],
                      style: nunitaSty().microText.copyWith(
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                    ),
                    SizedBox(
                      height: Dim().d8,
                    ),
                    Row(
                      children: [
                        Text(
                          bookingdetails['mobile_no'],
                          style: nunitaSty().microText.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        ),
                        SizedBox(
                          width: Dim().d12,
                        ),
                        SizedBox(
                          height: Dim().d24,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                  Dim().d8,
                                ))),
                                backgroundColor: Clr().green,
                              ),
                              onPressed: () {
                                STM().openDialer(bookingdetails['mobile_no']);
                              },
                              child: Text(
                                'call',
                                style: nunitaSty().smalltext.copyWith(
                                      color: Clr().white,
                                      fontWeight: FontWeight.w600,
                                    ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (statusList.last != 'completed_on')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                    child: Text(
                      'Service will start on : ${bookingdetails['service_start_date']}',
                      style: nunitaSty().smalltext.copyWith(
                            color: Theme.of(ctx).colorScheme.primary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Divider(
                    color: Clr().grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text(
                          'Est Cost : ₹${bookingdetails['est_cost']}',
                          style: nunitaSty().smalltext.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
                        child: Text(
                          'Est Duration : ${bookingdetails['est_duration']}',
                          style: nunitaSty().smalltext.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: Dim().d12,
            ),
          ],
        ),
      ),
    );
  }
}
