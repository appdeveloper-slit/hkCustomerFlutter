import 'package:flutter/material.dart';
import 'package:hk/values/dimens.dart';
import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'requetauth.dart';

class requestdetailPage extends StatefulWidget {
  final data;
  const requestdetailPage({super.key, this.data});

  @override
  State<requestdetailPage> createState() => _requestdetailPageState();
}

class _requestdetailPageState extends State<requestdetailPage> {
  late BuildContext ctx;
  var data;

  @override
  void initState() {
    // TODO: implement initState
    data = widget.data;
    Future.delayed(
      Duration.zero,
      () {
        requestAuthApi().bookingDetails(ctx, setState, data['id']);
      },
    );
    super.initState();
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
                '${data['service']}',
                style: nunitaSty().smalltext.copyWith(
                      color: Theme.of(ctx).colorScheme.primary == Clr().black
                          ? Clr().primaryColor
                          : Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${data['booking_status']}',
                      style: nunitaSty().extraLargeText.copyWith(
                            color: Theme.of(ctx).colorScheme.primary,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  data['booking_status'] == 'Pending'
                      ? Text(
                          'Our executives will contact you soon to understand your requirement',
                          textAlign: TextAlign.center,
                          style: nunitaSty().mediumText.copyWith(
                                color: Theme.of(ctx).colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                        )
                      : data['booking_status'] == 'Accepted'
                          ? Text(
                              'Your request has been accepted, we are searching a suitable partner for you',
                              textAlign: TextAlign.center,
                              style: nunitaSty().mediumText.copyWith(
                                    color: Theme.of(ctx).colorScheme.primary,
                                    fontWeight: FontWeight.w400,
                                  ),
                            )
                          : Container(),
                  SizedBox(
                    height: Dim().d12,
                  ),
                ],
              ),
            ),
          );
  }
}
