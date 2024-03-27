import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import '../manage/static_method.dart';
import 'authapi.dart';

class registerdetailPage extends StatefulWidget {
  final mobile;
  const registerdetailPage({super.key, this.mobile});

  @override
  State<registerdetailPage> createState() => _registerdetailPageState();
}

class _registerdetailPageState extends State<registerdetailPage> {
  late BuildContext ctx;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController redaddCtrl = TextEditingController();
  String? mapLoc, Slat, slng;
  var genderV;
  List genderList = ['Male', 'Female'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dim().d20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dim().d80),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create Account',
                    style: nunitaSty().extraLargeText.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(ctx).colorScheme.primary,
                        ),
                  )),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Name',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              TextFormField(
                controller: nameCtrl,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                style: nunitaSty().smalltext,
                cursorColor: Clr().black,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                      prefixIcon: Icon(
                        Icons.person_2_outlined,
                        color: Clr().hintColor,
                      ),
                      hintText: 'Enter Your Name',
                      hintStyle: nunitaSty().smalltext.copyWith(
                            color: Clr().hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                      filled: true,
                      fillColor: Clr().white,
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Email Address',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                style: nunitaSty().smalltext,
                cursorColor: Clr().black,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                      prefixIcon: Icon(
                        Icons.mail_outline,
                        color: Clr().hintColor,
                      ),
                      hintText: 'Enter Your Email Address',
                      hintStyle: nunitaSty().smalltext.copyWith(
                            color: Clr().hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                      filled: true,
                      fillColor: Clr().white,
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email id';
                  }
                  if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Gender',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              DropdownButtonFormField(
                dropdownColor: Clr().white,
                elevation: 0,
                isExpanded: true,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle,
                hint: Text(
                  genderV ?? 'Male',
                  style: nunitaSty().smalltext.copyWith(
                      color: Clr().black, fontWeight: FontWeight.w400),
                ),
                items: genderList.map((e) {
                  return DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.toString(),
                        style: nunitaSty().smalltext.copyWith(
                              color: Clr().black,
                              fontWeight: FontWeight.w400,
                            ),
                      ));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    genderV = value.toString();
                  });
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Date Of Birth',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              TextFormField(
                controller: dobCtrl,
                readOnly: true,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                onTap: () async {
                  var date = await STM().datePicker(ctx);
                  setState(() {
                    dobCtrl = TextEditingController(text: date);
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
                    hintText: "Select your Date of Birth",
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
                    return 'Please select a date of birth';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Residence Address',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              TextFormField(
                controller: redaddCtrl,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                style: nunitaSty().smalltext,
                cursorColor: Clr().black,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintText: 'Enter Your Address',
                      hintStyle: nunitaSty().smalltext.copyWith(
                            color: Clr().hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                      filled: true,
                      fillColor: Clr().white,
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Address';
                  }
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Text(
                'Map Location',
                style: nunitaSty().mediumText.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d4,
              ),
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                style: nunitaSty().smalltext,
                cursorColor: Clr().black,
                maxLines: mapLoc != null ? 4 : null,
                onTap: () async {
                  await loc.PlacesAutocomplete.show(
                      context: context,
                      apiKey: 'AIzaSyC4s2RytxTio18VZNUZ2cF4mzAySh0AfUM',
                      onError: (value) {
                        STM().errorDialog(ctx, value.status);
                      },
                      // call the onerror function below
                      mode: loc.Mode.overlay,
                      language: 'en',
                      //you can set any language for search
                      strictbounds: false,
                      types: [],
                      decoration: InputDecoration(
                          hintStyle: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(ctx).colorScheme.primary),
                          hintText: 'search...',
                          fillColor: Theme.of(ctx).colorScheme.background,
                          filled: true),
                      logo: Container(
                        height: 0,
                      ),
                      components: [] // you can determine search for just one country
                      ).then((v) async {
                    await locationFromAddress(v!.description.toString())
                        .then((value) {
                      setState(() {
                        mapLoc = v.description;
                        slng = value[0].longitude.toString();
                        Slat = value[0].latitude.toString();
                      });
                    });
                  });
                },
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                      hintMaxLines: null,
                      hintText: mapLoc ?? 'Enter Location',
                      hintStyle: nunitaSty().smalltext.copyWith(
                            color:
                                mapLoc != null ? Clr().black : Clr().hintColor,
                            fontWeight: FontWeight.w400,
                          ),
                      suffixIcon: Icon(
                        Icons.my_location_outlined,
                        color: Clr().black,
                      ),
                      filled: true,
                      fillColor: Clr().white,
                    ),
                validator: (value) {
                  if (mapLoc!.isEmpty) {
                    return 'Please enter a Address';
                  }
                },
              ),
              SizedBox(
                height: Dim().d20,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                        text: 'By Continuing I agree to ',
                        style: poppinsSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                        children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            // STM().redirect2page(ctx, const loginPage());
                          },
                          child: Text(
                            'Terms & Conditions',
                            style: nunitaSty().smalltext.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.pink,
                                ),
                          ),
                        ),
                      )
                    ])),
              ),
              SizedBox(
                height: Dim().d20,
              ),
              AnimatedButton(
                color: Clr().primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(Dim().d4)),
                pressEvent: () {
                  STM().checkInternet(ctx, widget).then((value) {
                    if (value) {
                      if (_formKey.currentState!.validate()) {
                        authapi().resgisterAuth(ctx, setState, [
                          nameCtrl.text,
                          widget.mobile,
                          emailCtrl.text,
                          genderV ?? 'Male',
                          dobCtrl.text,
                          redaddCtrl.text,
                          mapLoc,
                          Slat,
                          slng,
                        ]);
                      }
                    }
                  });
                },
                text: 'Sign Up',
                buttonTextStyle: nunitaSty().mediumText.copyWith(
                      color: Clr().white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSearch() async {
    // places.Prediction? p = await loc.PlacesAutocomplete.show(
    //     context: context,
    //     apiKey: 'AIzaSyAyKmLpB0xhYM7i1b7yirSZE0WXMGe2GQE',
    //     onError: onerror,
    //     // call the onerror function below
    //     mode: loc.Mode.overlay,
    //     language: 'en',
    //     //you can set any language for search
    //     strictbounds: false,
    //     types: [],
    //     decoration: InputDecoration(
    //         hintText: 'search...', fillColor: Clr().white, filled: true),
    //     logo: Container(
    //       height: 0,
    //     ),
    //     components: [] // you can determine search for just one country
    //     );
    // if (p == null) {
    //   setState(() {
    //     check = true;
    //   });
    // } else {
    //   setState(() {
    //     check = true;
    //   });
    // }
    // displayPrediction(p!.placeId, scaffoldState.currentState, p.description);
  }

  // Future<void> onerror(places.PlacesAutocompleteResponse response) async {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     elevation: 0,
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Colors.transparent,
  //     content: AwesomeSnackbarContent(
  //       title: 'Message',
  //       message: response.errorMessage!,
  //       contentType: ContentType.failure,
  //     ),
  //   ));
  // }
}
