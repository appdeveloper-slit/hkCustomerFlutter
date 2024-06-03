import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/strings.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'slotsSelectionPage.dart';

var selectedTest;
var selectedName;
var price;

class selecttest extends StatefulWidget {
  const selecttest({super.key});

  @override
  State<selecttest> createState() => _selecttestState();
}

class _selecttestState extends State<selecttest> {
  late BuildContext ctx;
  // List selectList = [];
  // List testPricesList = [];
  List testList = [];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      gettestapi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        surfaceTintColor: Clr().transparent,
        leading: InkWell(
           onTap: (){
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(ctx).colorScheme.primary == Clr().black
                ? Clr().primaryColor
                : Theme.of(ctx).colorScheme.primary,
          ),
        ),
        backgroundColor: Theme.of(ctx).colorScheme.background,
        title: Text(
          'Select Test',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d20),
              child: Container(
                decoration: BoxDecoration(
                    color: Clr().white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dim().d12),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Dim().d20),
                      child: Text(
                        'Select Test :',
                        style: nunitaSty().mediumText.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black26,
                    ),
                    SizedBox(
                      height: Dim().d350,
                      child: ListView.builder(
                        itemCount: testList.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(Dim().d20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    try {
                                      setState(() {
                                        selectedTest = testList[index]
                                                ['test_id']
                                            .toString()
                                            .replaceAll(',', '');
                                      });
                                    } catch (_) {
                                      setState(() {
                                        selectedTest =
                                            testList[index]['test_id'];
                                      });
                                    }
                                    print(selectedTest);
                                    setState(() {
                                      price = testList[index]['test_price'];
                                      selectedName =
                                          testList[index]['test_name'];
                                    });
                                  },
                                  child: selectedTest ==
                                          testList[index]['test_id']
                                              .toString()
                                              .replaceAll(',', '')
                                      ? Icon(
                                          Icons.check_box,
                                          color: Clr().primaryColor,
                                        )
                                      : Icon(
                                          Icons.check_box_outline_blank,
                                          color: Clr().primaryColor,
                                        ),
                                ),
                                SizedBox(
                                  width: Dim().d20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        testList[index]['test_name'],
                                        style: nunitaSty().smalltext.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      SizedBox(
                                        height: Dim().d16,
                                      ),
                                      Text(
                                        '₹${testList[index]['test_price']}',
                                        style: nunitaSty().smalltext.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Clr().primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    )),
                onPressed: () {
                  STM().redirect2page(ctx, const slotsSelectionPage());
                },
                child: Center(
                  child: Text(
                    'Next',
                    style: nunitaSty().smalltext.copyWith(color: Clr().white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void gettestapi() async {
    var result = await STM().allApi(
      apiname: 'blood_tests',
      type: 'get',
      ctx: ctx,
      load: true,
      loadtitle: Str().loading,
    );
    if (result['success'] == true) {
      setState(() {
        testList = result['bloodTests'];
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
