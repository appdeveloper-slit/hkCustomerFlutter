import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/profilelayout/profileapiauth.dart';
import 'package:hk/values/dimens.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login.dart';
import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';

class profileLayPage extends StatefulWidget {
  const profileLayPage({super.key});

  @override
  State<profileLayPage> createState() => _profileLayPageState();
}

class _profileLayPageState extends State<profileLayPage> {
  late BuildContext ctx;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? gender, mapLoc, Slat, slng;
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController resdCtrl = TextEditingController();
  List genderList = ['Male', 'Female'];

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        profileApi().getProfile(ctx, setState);
        Future.delayed(Duration(seconds: 1), () {
          nameCtrl = TextEditingController(text: profileData['full_name']);
          mobileCtrl = TextEditingController(text: profileData['mobile_no']);
          emailCtrl = TextEditingController(text: profileData['email']);
          dobCtrl = TextEditingController(text: profileData['dob']);
          resdCtrl = TextEditingController(text: profileData['address']);
          gender = profileData['gender'];
          mapLoc = profileData['location'];
          getSession(mapLoc);
        });
      },
    );
    super.initState();
  }

  getSession(loc) async {
    await locationFromAddress(loc.toString()).then((value) {
      setState(() {
        slng = value[0].longitude.toString();
        Slat = value[0].latitude.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        STM().finishAffinity(ctx, const Home());
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(ctx).colorScheme.background,
          elevation: 1,
          leading: InkWell(
            onTap: () {
              STM().finishAffinity(ctx, const Home());
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
            'My Profile',
            style: nunitaSty().smalltext.copyWith(
                  color: Theme.of(ctx).colorScheme.primary == Clr().black
                      ? Clr().primaryColor
                      : Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Dim().d20),
            child: profileData == null
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'User ID : ${profileData['custID']}',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().black
                                    ? Clr().primaryColor
                                    : Theme.of(ctx).colorScheme.primary,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Text(
                        'Name',
                        style: nunitaSty().mediumText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      TextFormField(
                        controller: nameCtrl,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        style: nunitaSty().smalltext.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                        decoration: nunitaSty()
                            .TextFormFieldOutlineDarkStyle
                            .copyWith(
                              prefixIcon: Icon(
                                Icons.person_2_outlined,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().black
                                    ? Colors.black54
                                    : Theme.of(ctx).colorScheme.primary,
                                size: Dim().d20,
                                weight: 12.0,
                              ),
                              filled: true,
                              fillColor: Theme.of(ctx).colorScheme.background ==
                                      Clr().white
                                  ? Clr().background
                                  : Theme.of(ctx).colorScheme.background,
                            ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          }
                        },
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Text(
                        'Mobile Number',
                        style: nunitaSty().mediumText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      TextFormField(
                        controller: mobileCtrl,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        style: nunitaSty().smalltext.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                        decoration: nunitaSty()
                            .TextFormFieldOutlineDarkStyle
                            .copyWith(
                              prefixIcon: Icon(
                                Icons.wifi_calling_sharp,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().black
                                    ? Colors.black54
                                    : Theme.of(ctx).colorScheme.primary,
                                size: Dim().d20,
                                weight: 12.0,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  mobileUpdate(ctx, setState);
                                },
                                child: Icon(
                                  Icons.edit_sharp,
                                  color: Theme.of(ctx).colorScheme.primary ==
                                          Clr().black
                                      ? Colors.black54
                                      : Theme.of(ctx).colorScheme.primary,
                                  size: Dim().d20,
                                  weight: 12.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Theme.of(ctx).colorScheme.background ==
                                      Clr().white
                                  ? Clr().background
                                  : Theme.of(ctx).colorScheme.background,
                            ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mobile number is required';
                          }
                          if (value.length != 10) {
                            return 'Mobile number must be 10 digits long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Text(
                        'Email Address',
                        style: nunitaSty().mediumText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        style: nunitaSty().smalltext.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                            ),
                        decoration: nunitaSty()
                            .TextFormFieldOutlineDarkStyle
                            .copyWith(
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().black
                                    ? Colors.black54
                                    : Theme.of(ctx).colorScheme.primary,
                                size: Dim().d20,
                                weight: 12.0,
                              ),
                              filled: true,
                              fillColor: Theme.of(ctx).colorScheme.background ==
                                      Clr().white
                                  ? Clr().background
                                  : Theme.of(ctx).colorScheme.background,
                            ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email id is required';
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
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: nunitaSty()
                            .TextFormFieldOutlineDarkStyle
                            .copyWith(
                              hintText: '$gender',
                              hintStyle: nunitaSty().mediumText.copyWith(
                                    color: Theme.of(ctx).colorScheme.primary,
                                    fontWeight: FontWeight.w400,
                                  ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().black
                                    ? Colors.black54
                                    : Theme.of(ctx).colorScheme.primary,
                                size: Dim().d20,
                                weight: 12.0,
                              ),
                              filled: true,
                              fillColor: Theme.of(ctx).colorScheme.background ==
                                      Clr().white
                                  ? Clr().background
                                  : Theme.of(ctx).colorScheme.background,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      Text(
                        'Date of Birth',
                        style: nunitaSty().mediumText.copyWith(
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
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
                        decoration:
                            nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
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
                              color: Theme.of(ctx).colorScheme.primary,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d4,
                      ),
                      TextFormField(
                        controller: resdCtrl,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        style: nunitaSty().smalltext,
                        cursorColor: Clr().black,
                        decoration:
                            nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
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
                                  fillColor:
                                      Theme.of(ctx).colorScheme.background,
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
                        decoration:
                            nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                                  hintMaxLines: null,
                                  hintText: mapLoc ?? 'Enter Location',
                                  hintStyle: nunitaSty().smalltext.copyWith(
                                        color: mapLoc != null
                                            ? Clr().black
                                            : Clr().hintColor,
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
                      AnimatedButton(
                        color: Clr().primaryColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dim().d4)),
                        pressEvent: () {
                          STM().checkInternet(ctx, widget).then((value) {
                            if (value) {
                              if (_formKey.currentState!.validate()) {
                                profileApi().updateProfile(ctx, setState, [
                                  nameCtrl.text,
                                  emailCtrl.text,
                                  gender,
                                  dobCtrl.text,
                                  resdCtrl.text,
                                  mapLoc,
                                  Slat,
                                  slng,
                                ]);
                              }
                            }
                          });
                        },
                        text: 'Update Profile',
                        buttonTextStyle: nunitaSty().mediumText.copyWith(
                              color: Clr().white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                      InkWell(
                        onTap: () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          setState(() {
                            sp.remove('login');
                            sp.remove('userid');
                            STM().finishAffinity(ctx, const loginPage());
                          });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Logout',
                            style: nunitaSty().mediumText.copyWith(
                                  color: Clr().red,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dim().d20,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  /// update mobile
  Future mobileUpdate(ctx, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    TextEditingController mobCtrl = TextEditingController();
    TextEditingController otpctrl = TextEditingController();
    bool loading = false;
    final _formKey = GlobalKey<FormState>();
    bool? checkStatus;
    bool? checkStatus1;
    return AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.noHeader,
        width: 600.0,
        isDense: true,
        context: ctx,
        body: StatefulBuilder(builder: (ctx, setState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loading == false
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text('Enter Mobile Number',
                                style: nunitaSty()
                                    .mediumText
                                    .copyWith(fontWeight: FontWeight.w600)),
                            SizedBox(height: Dim().d20),
                            TextFormField(
                              controller: mobCtrl,
                              maxLength: 10,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return 'Mobile number is required';
                                }
                                if (v.length != 10) {
                                  return 'Mobile number digits must be 10';
                                }
                                return null;
                              },
                              decoration: nunitaSty()
                                  .TextFormFieldOutlineDarkStyle
                                  .copyWith(
                                      hintText: 'Enter Mobile Number',
                                      counterText: "",
                                      hintStyle: nunitaSty()
                                          .mediumText
                                          .copyWith(color: Clr().hintColor)),
                            ),
                            SizedBox(height: Dim().d20),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Clr().primaryColor),
                                      onPressed: () {
                                        STM().back2Previous(ctx);
                                      },
                                      child: Center(
                                        child: Text('Cancel',
                                            style: nunitaSty()
                                                .mediumText
                                                .copyWith(color: Clr().white)),
                                      )),
                                ),
                                SizedBox(width: Dim().d8),
                                checkStatus == true
                                    ? CircularProgressIndicator(
                                        color: Clr().primaryColor)
                                    : Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Clr().primaryColor),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  checkStatus = true;
                                                });
                                                var result = await STM().allApi(
                                                    type: 'post',
                                                    ctx: ctx,
                                                    load: true,
                                                    loadtitle: 'Sending OTP',
                                                    body: {
                                                      'mobile': mobCtrl.text,
                                                      'page_type': 'register',
                                                    },
                                                    apiname: 'sendOTP');
                                                if (result['error'] != true) {
                                                  setState(() {
                                                    loading = true;
                                                    checkStatus = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    checkStatus = false;
                                                    loading = false;
                                                    mobCtrl.clear();
                                                    AwesomeDialog(
                                                            context: ctx,
                                                            dismissOnBackKeyPress:
                                                                false,
                                                            dismissOnTouchOutside:
                                                                false,
                                                            dialogType:
                                                                DialogType
                                                                    .error,
                                                            animType:
                                                                AnimType.scale,
                                                            headerAnimationLoop:
                                                                true,
                                                            title: 'Note',
                                                            desc: result[
                                                                'message'],
                                                            btnOkText: "OK",
                                                            btnOkOnPress: () {
                                                              Navigator.pop(
                                                                  ctx);
                                                            },
                                                            btnOkColor:
                                                                Clr().errorRed)
                                                        .show();
                                                  });
                                                }
                                              }
                                            },
                                            child: Center(
                                              child: Text('Send OTP',
                                                  style: nunitaSty()
                                                      .mediumText
                                                      .copyWith(
                                                          color: Clr().white)),
                                            )),
                                      )
                              ],
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Text('Enter OTP',
                              style: nunitaSty()
                                  .mediumText
                                  .copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(height: Dim().d20),
                          TextFormField(
                            controller: otpctrl,
                            maxLength: 4,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: nunitaSty()
                                .TextFormFieldOutlineDarkStyle
                                .copyWith(
                                    hintText: 'Enter OTP',
                                    counterText: '',
                                    hintStyle: nunitaSty()
                                        .mediumText
                                        .copyWith(color: Clr().hintColor)),
                          ),
                          SizedBox(height: Dim().d20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Clr().primaryColor),
                                    onPressed: () {
                                      setState(() {
                                        loading = false;
                                        otpctrl.clear();
                                        mobCtrl.clear();
                                      });
                                    },
                                    child: Center(
                                      child: Text('Back',
                                          style: nunitaSty()
                                              .mediumText
                                              .copyWith(color: Clr().white)),
                                    )),
                              ),
                              SizedBox(width: Dim().d12),
                              checkStatus1 == true
                                  ? CircularProgressIndicator(
                                      color: Clr().primaryColor)
                                  : Expanded(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Clr().primaryColor),
                                          onPressed: () async {
                                            setState(() {
                                              checkStatus1 = true;
                                            });
                                            // FormData body = FormData.fromMap({
                                            //   'phone': mobilectrl.text,
                                            //   'otp': otpctrl.text,
                                            // });
                                            // var result = await STM().allApi(
                                            //   apiname: 'profile/update/phone',
                                            //   token: sp.getString('token'),
                                            //   body: {
                                            //     'phone': mobilectrl.text,
                                            //     'otp': otpctrl.text,
                                            //   },
                                            //   loadtitle: 'OTP Verifying...',
                                            //   load: true,
                                            //   ctx: ctx,
                                            //   type: 'post',
                                            // );
                                            // if (result['success']) {
                                            //   setState(() {
                                            //     checkStatus1 = false;
                                            //     otpctrl.clear();
                                            //     mobilectrl.clear();
                                            //   });
                                            //   STM().successsDialogWithAffinity(
                                            //       ctx,
                                            //       result['message'],
                                            //       Home());
                                            // } else {
                                            //   setState(() {
                                            //     checkStatus1 = false;
                                            //     otpctrl.clear();
                                            //   });
                                            // STM().errorDialog(
                                            //     ctx, result['message']);
                                            // }
                                            var result = await STM().allApi(
                                                type: 'post',
                                                ctx: ctx,
                                                load: true,
                                                loadtitle: 'Processing...',
                                                body: {
                                                  'mobile': mobCtrl.text,
                                                  'user_id':
                                                      sp.getString('userid'),
                                                  'otp': otpctrl.text,
                                                },
                                                apiname: 'change_mobile');
                                            if (result['error'] != true) {
                                              setState(() {
                                                checkStatus1 = false;
                                                otpctrl.clear();
                                                mobileCtrl =
                                                    TextEditingController(
                                                  text: mobCtrl.text,
                                                );
                                                mobCtrl.clear();
                                                STM().back2Previous(ctx);
                                              });
                                            } else {
                                              setState(() {
                                                checkStatus1 = false;
                                                loading = false;
                                                otpctrl.clear();
                                                STM().errorDialog(
                                                    ctx, result['message']);
                                              });
                                            }
                                          },
                                          child: Center(
                                            child: Text('Submit',
                                                style: nunitaSty()
                                                    .mediumText
                                                    .copyWith(
                                                        color: Clr().white)),
                                          )),
                                    )
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          );
        })).show();
  }
}

class mobileLayout extends StatelessWidget {
  const mobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Container();
      },
    );
  }
}
