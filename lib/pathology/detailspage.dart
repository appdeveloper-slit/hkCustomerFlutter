import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/dimens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homedirectory/home.dart';
import '../values/colors.dart';
import '../values/styles.dart';

class detailspage extends StatefulWidget {
  final data, bookingid;
  const detailspage({super.key, this.data, this.bookingid});

  @override
  State<detailspage> createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  late BuildContext ctx;
  bool checkLoader = true;
  var bookingstatus;
  var bookingdescription;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      getTokken();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Theme.of(ctx).colorScheme.primary == Clr().black
              ? Clr().primaryColor
              : Theme.of(ctx).colorScheme.primary,
        ),
        elevation: 1,
        backgroundColor: Theme.of(ctx).colorScheme.background,
        title: Text(
          'Booking Details',
          style: nunitaSty().extraLargeText.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(Dim().d12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Booking Status',
                    style: nunitaSty().mediumText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  Row(
                    children: [
                      Text(
                        bookingstatus,
                        style: nunitaSty().microText.copyWith(
                              fontWeight: FontWeight.w300,
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                      SizedBox(
                        width: Dim().d8,
                      ),
                      GestureDetector(
                        onTap: () {
                          tooltipkey.currentState!.ensureTooltipVisible();
                        },
                        child: Tooltip(
                          message: bookingdescription,
                          key: tooltipkey,
                          child: Icon(
                            Icons.info,
                            color: Clr().primaryColor,
                            size: Dim().d16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Divider(
                color: Clr().grey,
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Text(
                'Patient Details',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dim().d12),
              padding: EdgeInsets.all(Dim().d12),
              decoration: BoxDecoration(
                color: Clr().white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dim().d12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Clr().primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(Dim().d20),
                      child: Text(
                        'A',
                        // STM().getCharString(widget.data['customer_details'][0]['customer_name']),
                        style: nunitaSty().extraLargeText.copyWith(
                              color: Clr().white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dim().d12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ashish Gupta',
                          //widget.data['customer_details'][0]['customer_name'],
                          style: nunitaSty().largeText.copyWith(
                                color: Clr().black,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        SizedBox(
                          height: Dim().d8,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Male',
                              // widget.data['customer_details'][0]['gender'],
                              style: nunitaSty()
                                  .mediumText
                                  .copyWith(color: Clr().hintColor),
                            ),
                            SizedBox(
                              width: Dim().d12,
                            ),
                            Text(
                              '21',
                              //'${widget.data['customer_details'][0]['age']} years',
                              style: nunitaSty().mediumText.copyWith(
                                    color: Clr().hintColor,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Text(
                'Selected Tests',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dim().d12),
              padding: EdgeInsets.all(Dim().d12),
              decoration: BoxDecoration(
                color: Clr().white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dim().d12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Test',
                    //widget.data['package_details'][0]['test_name'],
                    style: nunitaSty().smalltext.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Clr().black,
                        ),
                  ),
                  Text(
                    'Test',
                    //widget.data['package_details'][0]['test_price'],
                    style: nunitaSty().smalltext.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Clr().black,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Text(
                'Address',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dim().d12),
              padding: EdgeInsets.all(Dim().d12),
              decoration: BoxDecoration(
                color: Clr().white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dim().d12),
                ),
              ),
              child: Text(
                'the ksdlvsdn dwlkvnlkn fdlvkfn kefbnefk k nfpke rfkppkinbekfpnfpifnve iefnvefvnefiof iekfbnpefbnep fkpefnpef n',
                //widget.data['address'],
                style: nunitaSty().smalltext.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Clr().black,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d12),
              child: Text(
                'Price Summary',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dim().d12),
              padding: EdgeInsets.all(Dim().d12),
              decoration: BoxDecoration(
                color: Clr().white,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dim().d12),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Test Charges',
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().black,
                            ),
                      ),
                      Text(
                        '999',
                        //widget.data['discounted_price'],
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().black,
                            ),
                      )
                    ],
                  ),
                  Divider(
                    color: Clr().grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().black,
                            ),
                      ),
                      Text(
                        '999',
                        //widget.data['discounted_price'],
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().black,
                            ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            if (bookingstatus == 'Pickup Scheduled' ||
                bookingstatus == 'Order Booked' ||
                bookingstatus == 'Rescheduled')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )),
                  onPressed: () {
                    cancelbooking();
                  },
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: nunitaSty().smalltext.copyWith(color: Clr().white),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: Dim().d12,
            ),
            if (bookingstatus == 'Pickup Scheduled' ||
                bookingstatus == 'Order Booked')
              InkWell(
                onTap: () {
                  reshedulebooking();
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Reschedule Booking',
                    style: nunitaSty()
                        .mediumText
                        .copyWith(color: Clr().primaryColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void cancelbooking() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "booking_id": widget.bookingid,
      "vendor_billing_user_id": "1234567",
      "vendor_customer_id": "1234567",
      "remarks": "CUSTOMER_CANCELLED"
    };
    var result = await STM().pathologyApi(
        apiname: 'cancelBooking',
        body: body,
        ctx: ctx,
        type: 'post',
        token: sp.getString('pathotoken'));
    if (result['status'] == true) {
      STM().successsDialogWithAffinity(ctx, result['message'], const Home());
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void reshedulebooking() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "booking_id": widget.bookingid,
      "slot": {"slot_id": "3102608"},
      "customers": [
        {"vendor_customer_id": "ddddddddddddd"}
      ],
      "reschedule_reason": "RESCHEDULED TO ANOTHER DATE"
    };
    var result = await STM().pathologyApi(
        apiname: 'rescheduleBookingByCustomer_v1',
        body: body,
        ctx: ctx,
        type: 'post',
        token: sp.getString('pathotoken'));
    if (result['status'] == true) {
      STM().successsDialogWithAffinity(ctx, result['message'], const Home());
    } else {
      STM().errorDialog(ctx, result['message']);
    }
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
        checkLoader = false;
        getbookingstatus();
      });
    } else {
      STM().errorDialogWithinffinity(ctx, result['message'], const Home());
    }
  }

  void getbookingstatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {"booking_id": widget.bookingid};
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
          });
          break;
        case "BS003":
          setState(() {
            bookingstatus = 'Cancelled';
            bookingdescription = "Order Cancelled";
          });
          break;
        case "BS005":
          setState(() {
            bookingstatus = 'Pickup Scheduled';
            bookingdescription = "Booking is verified";
          });
          break;
        case "BS006":
          setState(() {
            bookingstatus = 'Sample Collector Reached Home';
            bookingdescription = "Sample Collector Reached Home";
          });
          break;
        case "BS007":
          setState(() {
            bookingstatus = 'Sample Collected';
            bookingdescription = "Sample Collected";
          });
          break;
        case "BS008":
          setState(() {
            bookingstatus = 'Sample Received at Lab';
            bookingdescription = "Sample Received at Lab";
          });
          break;
        case "BS009":
          setState(() {
            bookingstatus = 'Report Generated';
            bookingdescription =
                "Report Generated from the Lab but pending for verification";
          });
          break;
        case "BS0012":
          setState(() {
            bookingstatus = 'Health Counselling';
            bookingdescription = "Doctor Consultation Done";
          });
          break;
        case "BS0013":
          setState(() {
            bookingstatus = 'Rescheduled';
            bookingdescription = "Booking Reschedule";
          });
          break;
        case "BS0015":
          setState(() {
            bookingstatus = 'Report Available';
            bookingdescription = "Report is available and send to customer";
          });
          break;
        case "BS0018":
          setState(() {
            bookingstatus = 'Resampling Process Initiated';
            bookingdescription = "Resampling Process Initiated";
          });
          break;
        case "BS0021":
          setState(() {
            bookingstatus = 'Missed Doctor Consultation';
            bookingdescription = "Doctor Consultation Call Missed";
          });
          break;
        case "BS0023":
          setState(() {
            bookingstatus = 'Reject Sample';
            bookingdescription = "Sample got Reject due to some reason";
          });
          break;
        case "BS0026":
          setState(() {
            bookingstatus = "Sample Collector's Call Not Picked";
            bookingdescription = "Sample Collector's Call Not Picked";
          });
          break;
        case "BS0027":
          setState(() {
            bookingstatus = "Payment issue - hold";
            bookingdescription = "Booking is on-hold due to Payment Issue";
          });
          break;
        default:
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
