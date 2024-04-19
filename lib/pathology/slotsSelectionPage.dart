// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/styles.dart';
import 'addpatient.dart';

Map slotData = {};

class slotsSelectionPage extends StatefulWidget {
  const slotsSelectionPage({super.key});

  @override
  State<slotsSelectionPage> createState() => _slotsSelectionPageState();
}

class _slotsSelectionPageState extends State<slotsSelectionPage> {
  late BuildContext ctx;
  TextEditingController dateCtrl = TextEditingController();
  List dateList = [];
  bool? checkLoader;
  int _selectIndex = -1;

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
          'Select Slot',
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
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dim().d20, vertical: Dim().d40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: dateCtrl,
                readOnly: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onTap: () async {
                  var date = await STM().pathodatePicker(ctx);
                  setState(() {
                    dateCtrl = TextEditingController(text: date);
                    slotsGetApi(date);
                  });
                },
                cursorColor: Clr().black,
                style: nunitaSty().mediumText,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                obscureText: false,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                    filled: true,
                    fillColor: Clr().white,
                    hintStyle: nunitaSty().smalltext.copyWith(
                          color: Clr().hintColor,
                        ),
                    hintText: "Select Date for appointment",
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Dim().d0,
                      vertical: Dim().d14,
                    ),
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: Clr().hintColor,
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select Date for appointment';
                  } else {
                    return null;
                  }
                },
              ),
              if (dateList.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: Dim().d20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available Slots',
                        style: nunitaSty().extraLargeText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      // ignore: prefer_const_constructors
                      GridView.builder(
                        itemCount: dateList.length,
                        shrinkWrap: true,
                        // ignore: prefer_const_constructors
                        physics: NeverScrollableScrollPhysics(),
                        // ignore: prefer_const_constructors
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 22 / 6,
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 12.0),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                slotData = dateList[index];
                                _selectIndex = index;
                                print(slotData);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      color: Colors.black26,
                                      offset: Offset(0, 3),
                                    )
                                  ],
                                  color: _selectIndex == index
                                      ? Clr().primaryColor
                                      : Clr().white,
                                  border: Border.all(
                                    width: 1,
                                    color: Clr().primaryColor,
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dim().d12))),
                              child: Center(
                                child: Text(
                                  // ignore: unnecessary_string_interpolations
                                  '${DateFormat('hh:mm a').format(
                                    DateTime.parse(
                                      '${dateList[index]['slot_date']} ${dateList[index]['slot_time']}',
                                    ),
                                  )} to ${DateFormat('hh:mm a').format(
                                    DateTime.parse(
                                      '${dateList[index]['slot_date']} ${dateList[index]['end_time']}',
                                    ),
                                  )}',
                                  style: nunitaSty().microText.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: _selectIndex == index
                                            ? Clr().white
                                            : Clr().primaryColor,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: Dim().d40,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: Dim().d48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Clr().primaryColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            onPressed: () {
                              STM().redirect2page(ctx, const addPatinetPage());
                            },
                            child: Text(
                              'Next',
                              style: nunitaSty().mediumBoldText.copyWith(
                                    color: Clr().white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (checkLoader == true)
                SizedBox(
                  height: 600.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/nillslot.png',
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        height: Dim().d12,
                      ),
                      Text(
                        "Currently, all slots for the selected date have been filled. Please feel free to select another date that works best for you.",
                        textAlign: TextAlign.center,
                        style: nunitaSty()
                            .mediumText
                            .copyWith(color: Theme.of(ctx).colorScheme.primary),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void slotsGetApi(date) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "zipcode": sp.getString('pathZipcode'),
      "lat": sp.getString('lat'),
      "long": sp.getString('lng'),
      "slot_date": date,
    };
    print(body);
    print(sp.getString('pathotoken'));
    var result = await STM().pathologyApi(
      ctx: ctx,
      apiname: 'getSlotsByZipCode_v1',
      body: body,
      load: true,
      loadtitle: 'Checking...',
      type: 'post',
      token: sp.getString('pathotoken'),
    );
    if (result['status'] == true) {
      setState(() {
        dateList = result['data'];
      });
      if (dateList.isEmpty) {
        setState(() {
          checkLoader = true;
        });
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
