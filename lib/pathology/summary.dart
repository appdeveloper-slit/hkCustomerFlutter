import 'package:flutter/material.dart';
import 'package:hk/pathology/addpatient.dart';
import 'package:hk/pathology/slotsSelectionPage.dart';
import 'package:hk/values/dimens.dart';
import 'package:intl/intl.dart';
import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'selectLocationPage.dart';

class summaryPage extends StatefulWidget {
  const summaryPage({super.key});

  @override
  State<summaryPage> createState() => _summaryPageState();
}

class _summaryPageState extends State<summaryPage> {
  late BuildContext ctx;
  TextEditingController addCtrl = TextEditingController();

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
                        Column(
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
                                  patientdata['gender'].toString().contains('M')
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
                          '₹ 1000',
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
                    '₹ 1000',
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
                        print(addressList);
                        print(slotData);
                        print(patientdata);
                      },
                      child: Text(
                        'Proceed',
                        style: nunitaSty().mediumText.copyWith(
                              color: Clr().primaryColor,
                            ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
