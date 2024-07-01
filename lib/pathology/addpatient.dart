import 'package:flutter/material.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/pathology/slotsSelectionPage.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:uuid/uuid.dart';
import '../values/styles.dart';
import 'summary.dart';

Map patientdata = {};

class addPatinetPage extends StatefulWidget {
  const addPatinetPage({super.key});

  @override
  State<addPatinetPage> createState() => _addPatinetPageState();
}

class _addPatinetPageState extends State<addPatinetPage> {
  late BuildContext ctx;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController numCtrl = TextEditingController();
  var uuid = const Uuid();
  final _formKey = GlobalKey<FormState>();

  List relationList = [
    'Self',
    'Spouse',
    'Child',
    'Parent',
    'Grand parent',
    'Sibling',
    'Friend',
    'Native',
    'Neighbour',
    'Colleague',
    'Others',
  ];
  List ageList = [
    'Male',
    'Female',
  ];
  String? relValue, ageValue, agecheck, relcheck;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        surfaceTintColor: Clr().transparent,
        shadowColor: Clr().black,
        backgroundColor: Theme.of(ctx).colorScheme.background,
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
        title: Text(
          'Add Patient',
          style: nunitaSty().extraLargeText.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dim().d20, vertical: Dim().d20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Name',
                  style: nunitaSty().mediumText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                TextFormField(
                  controller: nameCtrl,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  style: nunitaSty().mediumText,
                  decoration: nunitaSty().TextFormFieldGreyDarkStyle.copyWith(
                        fillColor: Clr().white,
                        filled: true,
                        hintText: 'Enter name',
                        hintStyle: nunitaSty().smalltext.copyWith(
                              color: Clr().hintColor,
                            ),
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                Text(
                  'Relation',
                  style: nunitaSty().mediumText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Clr().white,
                    border: Border.all(
                      color: Clr().black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dim().d12),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d12),
                    child: DropdownButton(
                      underline: Container(),
                      dropdownColor: Clr().white,
                      isExpanded: true,
                      isDense: true,
                      value: relValue,
                      style: nunitaSty().mediumText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                      hint: Text(
                        'Select relation',
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().hintColor,
                            ),
                      ),
                      items: relationList.map((e) {
                        return DropdownMenuItem(
                          value: e.toString(),
                          child: Text(
                            e.toString(),
                            style: nunitaSty().mediumText,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          relValue = v.toString();
                          relcheck = null;
                        });
                      },
                    ),
                  ),
                ),
                relcheck != null
                    ? Text(
                        '$relcheck',
                        style: nunitaSty().smalltext.copyWith(
                              color: Clr().errorRed,
                              fontWeight: FontWeight.w400,
                            ),
                      )
                    : Container(),
                SizedBox(
                  height: Dim().d20,
                ),
                Text(
                  'Age',
                  style: nunitaSty().mediumText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                TextFormField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: nunitaSty().mediumText,
                  decoration: nunitaSty().TextFormFieldGreyDarkStyle.copyWith(
                        fillColor: Clr().white,
                        filled: true,
                        hintText: 'Enter age (Age range between 5-120)',
                        hintStyle: nunitaSty().smalltext.copyWith(
                              color: Clr().hintColor,
                            ),
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    }
                    if (int.parse(value.toString()) < 5) {
                      return 'Age must be greater than 5';
                    }
                  },
                ),
                SizedBox(
                  height: Dim().d20,
                ),
                Text(
                  'Select Gender',
                  style: nunitaSty().mediumText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Clr().white,
                    border: Border.all(
                      color: Clr().black,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dim().d12),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dim().d12),
                    child: DropdownButton(
                      underline: Container(),
                      dropdownColor: Clr().white,
                      isExpanded: true,
                      isDense: true,
                      value: ageValue,
                      style: nunitaSty().mediumText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                      hint: Text(
                        'Select gender',
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().hintColor,
                            ),
                      ),
                      items: ageList.map((e) {
                        return DropdownMenuItem(
                          value: e.toString(),
                          child: Text(
                            e.toString(),
                            style: nunitaSty().mediumText,
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          ageValue = v.toString();
                          agecheck = null;
                        });
                      },
                    ),
                  ),
                ),
                agecheck != null
                    ? Text(
                        '$agecheck',
                        style: nunitaSty().smalltext.copyWith(
                              color: Clr().errorRed,
                              fontWeight: FontWeight.w400,
                            ),
                      )
                    : Container(),
                SizedBox(
                  height: Dim().d20,
                ),
                Text(
                  'Contact Number',
                  style: nunitaSty().mediumText.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(ctx).colorScheme.primary,
                      ),
                ),
                SizedBox(
                  height: Dim().d12,
                ),
                TextFormField(
                  controller: numCtrl,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: nunitaSty().mediumText,
                  decoration: nunitaSty().TextFormFieldGreyDarkStyle.copyWith(
                        errorMaxLines: 2,
                        counterText: "",
                        fillColor: Clr().white,
                        filled: true,
                        hintText: 'Enter contact number',
                        hintStyle: nunitaSty().smalltext.copyWith(
                              color: Clr().hintColor,
                            ),
                      ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Contact number is required';
                    }
                    if (value.length < 10) {
                      return 'Contact number should indeed be 10 digits long';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: Dim().d36,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: Dim().d40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Clr().primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          validate();
                        }
                      },
                      child: Center(
                        child: Text(
                          'Submit',
                          style: nunitaSty().mediumBoldText.copyWith(
                                color: Clr().white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    bool check = _formKey.currentState!.validate();
    if (ageValue == null) {
      setState(() {
        agecheck = 'Age is required';
        check = false;
      });
    } else if (relValue == null) {
      setState(() {
        relcheck = 'Relation is required';
        check = false;
      });
    } else {
      setState(() {
        check = true;
      });
    }
    if (check) {
      patientdata = {
        "customer_id": STM().getChecksumKey(nameCtrl.text).toString(),
        "customer_name": nameCtrl.text,
        "relation": relValue.toString().toLowerCase(),
        "age": ageCtrl.text,
        "gender": ageValue.toString()[0],
        "contact_number": numCtrl.text,
      };
      STM().displayToast('Patient Added');
      STM().redirect2page(ctx, const summaryPage());
    }
  }
}
