import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          children: [
            Padding(
              padding: EdgeInsets.all(Dim().d20),
              child: Row(
                children: [
                  Text(
                    'Booking Status',
                    style: nunitaSty().mediumText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                ],
              ),
            )
          ],
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
        default:
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
