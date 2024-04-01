import 'package:flutter/material.dart';
import 'package:hk/values/dimens.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';
import 'requetauth.dart';

class cancelRequest extends StatefulWidget {
  final id;
  const cancelRequest({super.key, this.id});

  @override
  State<cancelRequest> createState() => _cancelRequestState();
}

class _cancelRequestState extends State<cancelRequest> {
  late BuildContext ctx;
  String? _selectedValue;
  TextEditingController _otherValueController = TextEditingController();
  List itemList = [
    "Lack of accountability by service providing staff",
    "Not following proper schedule",
    "Hard to reach office staff",
    "Service is unaffordable or expensive",
    "The service giving staff is not professionally Trend and lacking skills",
    "Other",
  ];
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.background == Clr().white
            ? Clr().white
            : Theme.of(ctx).colorScheme.background,
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
        // centerTitle: true,
        // title: Text(
        //   'My Request',
        //   style: nunitaSty().extraLargeText.copyWith(
        //         color: Theme.of(ctx).colorScheme.primary == Clr().black
        //             ? Clr().primaryColor
        //             : Theme.of(ctx).colorScheme.primary,
        //         fontWeight: FontWeight.w400,
        //       ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dim().d20, vertical: Dim().d20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(Dim().d8)),
                    border: Border.all(
                      color: Clr().black.withOpacity(0.5),
                      width: 0.2,
                    ),
                  ),
                  child: DropdownButton(
                    value: _selectedValue,
                    underline: Container(),
                    hint: Text(
                      '     Select a reason',
                      style: nunitaSty().microText.copyWith(
                          color: Theme.of(ctx).colorScheme.primary,
                          fontWeight: FontWeight.w400),
                    ),
                    isExpanded: true,
                    elevation: 2,
                    style: nunitaSty().smalltext.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue;
                        _otherValueController.clear();
                      });
                    },
                    items: itemList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dim().d16,
                          ),
                          child: Text(
                            value,
                            style: nunitaSty().smalltext.copyWith(
                                  color: Theme.of(ctx).colorScheme.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )),
            if (_selectedValue == "Other")
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d20),
                child: TextFormField(
                    controller: _otherValueController,
                    style: nunitaSty().smalltext.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Clr().black,
                        ),
                    decoration:
                        nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                            hintText: 'Enter The Reason',
                            hintStyle: nunitaSty().smalltext.copyWith(
                                  color: Clr().hintColor,
                                ))),
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dim().d56,
                vertical: Dim().d20,
              ),
              child: SizedBox(
                height: Dim().d44,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(Dim().d2)))),
                    onPressed: () {
                      if (_selectedValue == 'Other') {
                        _otherValueController.text.isEmpty
                            ? STM().displayToast('Plese write a reason')
                            : requestAuthApi().cancelBooking(ctx, setState,
                                widget.id, _otherValueController.text);
                      } else {
                        _selectedValue == null
                            ? STM().displayToast('Please select a reason.')
                            : requestAuthApi().cancelBooking(
                                ctx, setState, widget.id, _selectedValue);
                      }
                    },
                    child: Text(
                      'Submit',
                      style: nunitaSty().mediumText.copyWith(
                            color: Clr().white,
                            fontWeight: FontWeight.w600,
                          ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
