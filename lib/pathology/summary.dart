// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/pathology/addpatient.dart';
import 'package:hk/pathology/slotsSelectionPage.dart';
import 'package:hk/values/dimens.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../manage/static_method.dart';
import '../profilelayout/profileapiauth.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'detailspage.dart';
import 'selectLocationPage.dart';
import 'selecttest.dart';

class summaryPage extends StatefulWidget {
  const summaryPage({super.key});

  @override
  State<summaryPage> createState() => _summaryPageState();
}

class _summaryPageState extends State<summaryPage> {
  late BuildContext ctx;
  TextEditingController addCtrl = TextEditingController();
  var uuid = const Uuid();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      profileApi().getProfile(ctx, setState);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Clr().black,
        backgroundColor: Theme.of(ctx).colorScheme.background,
        leading: Icon(
          Icons.arrow_back,
          color: Theme.of(ctx).colorScheme.primary == Clr().black
              ? Clr().primaryColor
              : Theme.of(ctx).colorScheme.primary,
        ),
        title: Text(
          'Summary',
          style: nunitaSty().extraLargeText.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Dim().d20,
                vertical: Dim().d32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
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
                              STM().getCharString(patientdata['customer_name']),
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
                                patientdata['customer_name'],
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
                                    patientdata['gender']
                                            .toString()
                                            .contains('M')
                                        ? 'Male'
                                        : 'Female',
                                    style: nunitaSty()
                                        .mediumText
                                        .copyWith(color: Clr().hintColor),
                                  ),
                                  SizedBox(
                                    width: Dim().d12,
                                  ),
                                  Text(
                                    '${patientdata['age']} years',
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
                    height: Dim().d24,
                  ),
                  Text(
                    'Selected Slot',
                    style: nunitaSty().largeText.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Container(
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
                    child: Padding(
                      padding: EdgeInsets.all(Dim().d8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${slotData['slot_date']} | ${STM().getdate(slotData['slot_time'], slotData['end_time'], slotData['slot_date'])} | ${STM().getDay(slotData['slot_date'], slotData['slot_time'])}',
                              style: nunitaSty().microText.copyWith(
                                    color: Clr().primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dim().d24,
                  ),
                  Text(
                    'Enter Full Address',
                    style: nunitaSty().largeText.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  TextFormField(
                    controller: addCtrl,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    style: nunitaSty().mediumText,
                    decoration: nunitaSty().TextFormFieldGreyDarkStyle.copyWith(
                          fillColor: Clr().white,
                          filled: true,
                          hintText: 'Enter a address',
                          hintStyle: nunitaSty().smalltext.copyWith(
                                color: Clr().hintColor,
                              ),
                        ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dim().d24,
                  ),
                  Text(
                    'Price Summary',
                    style: nunitaSty().largeText.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  ),
                  SizedBox(
                    height: Dim().d12,
                  ),
                  Container(
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
                          'Total',
                          style: nunitaSty().mediumText,
                        ),
                        Text(
                          '₹ $price',
                          style: nunitaSty().mediumText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Clr().primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dim().d20),
                topRight: Radius.circular(Dim().d20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ $price',
                    style: nunitaSty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dim().d8),
                          ),
                        )),
                    onPressed: () {
                      if (addCtrl.text.isEmpty) {
                        STM().displayToast('Please enter a full adreess.');
                      } else {
                        print(addressList);
                        print(slotData);
                        print(patientdata);
                        print(profileData);
                        addBookingApi();
                      }
                      // print(addressList);
                      // print(slotData);
                      // print(patientdata);
                    },
                    child: Text(
                      'Proceed',
                      style: nunitaSty().mediumText.copyWith(
                            color: Clr().primaryColor,
                          ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addBookingApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "customer": [patientdata],
      "slot": {
        "slot_id": slotData['stm_id'],
      },
      "package": [
        {
          "deal_id": ["package_$selectedTest"]
        },
      ],
      "customer_calling_number": patientdata['contact_number'],
      "billing_cust_name": profileData['full_name'],
      "gender": profileData['gender'].toString()[0].toUpperCase(),
      "mobile": profileData['mobile_no'],
      "email": profileData['email'],
      "latitude": Slat,
      "longitude": slng,
      "address": addCtrl.text,
      "sub_locality": addCtrl.text,
      "zipcode": addressList[0].postalCode ?? addressList[1].postalCode,
      "vendor_billing_user_id": patientdata['relation'] == 'self'
          ? patientdata['customer_id']
          : STM()
              .getChecksumKey(profileData['full_name'].toString())
              .toString(),
      "payment_option": "cod",
      "discounted_price": price,
    };
    print(body);
    // ignore: use_build_context_synchronously
    var result = await STM().pathologyApi(
      ctx: ctx,
      apiname: 'createBooking_v1',
      type: 'post',
      body: body,
      load: true,
      loadtitle: 'Processing...',
      token: sp.getString('pathotoken'),
    );
    if (result['status'] == true) {
      addbokkingApi(result['booking_id']);
    } else if (result['error'] != null) {
      // ignore: use_build_context_synchronously
      STM().errorDialog(ctx, result['error']);
    } else {
      // ignore: use_build_context_synchronously
      STM().errorDialog(ctx, result['message']);
    }
  }

  /// backend laravel required api
  /// this api use for store bookings in backend or database
  void addbokkingApi(id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "booking_id": id,
      "customer_id": sp.getString('userid'),
      "customer_details": [patientdata],
      "slot_id": slotData['stm_id'],
      "slot_time": '${DateFormat('hh:mm a').format(
        DateTime.parse(
          '${slotData['slot_date']} ${slotData['slot_time']}',
        ),
      )} to ${DateFormat('hh:mm a').format(
        DateTime.parse(
          '${slotData['slot_date']} ${slotData['end_time']}',
        ),
      )}',
      "booking_date": slotData['slot_date'],
      "package_details": [
        {
          "test_id": selectedTest,
          "test_name": selectedName,
          "test_price": price,
        }
      ],
      "customer_calling_number": patientdata['contact_number'],
      "billing_cust_name": profileData['full_name'],
      "gender": profileData['gender'].toString()[0].toUpperCase(),
      "mobile": profileData['mobile_no'],
      "email": profileData['email'],
      "latitude": Slat,
      "longitude": slng,
      "address": addCtrl.text,
      "sub_locality": addCtrl.text,
      "zipcode": addressList[0].postalCode ?? addressList[1].postalCode,
      "vendor_billing_user_id": patientdata['relation'] == 'self'
          ? patientdata['customer_id']
          : STM().getChecksumKey(profileData['full_name'].toString()),
      "payment_option": "cod",
      "discounted_price": price,
    };
    print(body);
    var result = await STM().allApi(
      ctx: ctx,
      apiname: 'create_booking',
      type: 'post',
      body: body,
      load: true,
      loadtitle: 'Processing...',
    );
    if (result['success'] == true) {
      STM().successsDialogWithAffinity(
          ctx,
          result['message'],
          detailspage(
            data: result['data'],
            bookingid: result['data']['booking_id'],
          ));
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
