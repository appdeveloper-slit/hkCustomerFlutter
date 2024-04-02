import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/requests/requetauth.dart';
import 'package:hk/values/dimens.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'requestdetail.dart';

class requestPage extends StatefulWidget {
  const requestPage({super.key});

  @override
  State<requestPage> createState() => _requestPageState();
}

class _requestPageState extends State<requestPage> {
  late BuildContext ctx;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        requestAuthApi().getallRequest(ctx, setState);
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
      requestAuthApi().getallRequest(ctx, setState);
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.background == Clr().white
            ? Clr().white
            : Theme.of(ctx).colorScheme.background,
        // shadowColor: Colors.black12,
        elevation: 2,
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
          'My Request',
          style: nunitaSty().extraLargeText.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
        ),
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
                  itemCount: requestArrayList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Dim().d16),
                      child: InkWell(
                        onTap: () {
                          STM().redirect2page(
                              ctx,
                              requestdetailPage(
                                data: requestArrayList[index],
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
                                SvgPicture.network(
                                  requestArrayList[index]['image_path'],
                                  height: Dim().d44,
                                  width: Dim().d60,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: Dim().d20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${requestArrayList[index]['service']}',
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
                                    Text(
                                      requestArrayList[index]['is_cancel'] ==
                                              true
                                          ? "Cancelled"
                                          : '${requestArrayList[index]['booking_status']}',
                                      style: nunitaSty().smalltext.copyWith(
                                            color: requestArrayList[index]
                                                        ['is_cancel'] ==
                                                    true
                                                ? Clr().errorRed
                                                : requestArrayList[index][
                                                            'booking_status'] ==
                                                        'Pending'
                                                    ? Clr().yellow
                                                    : requestArrayList[index][
                                                                'booking_status'] ==
                                                            'Completed'
                                                        ? Clr().successGreen
                                                        : Theme.of(ctx)
                                                            .colorScheme
                                                            .primary,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                    SizedBox(
                                      height: Dim().d4,
                                    ),
                                    Text(
                                      '${requestArrayList[index]['date']}',
                                      style: nunitaSty().microText.copyWith(
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
    );
  }
}
