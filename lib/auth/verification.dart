import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hk/auth/authapi.dart';
import 'package:hk/values/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/dimens.dart';

class verificationPage extends StatefulWidget {
  final sMobile, type;
  const verificationPage({super.key, this.sMobile, this.type});

  @override
  State<verificationPage> createState() => _verificationPageState();
}

class _verificationPageState extends State<verificationPage> {
  late BuildContext ctx;
  TextEditingController otpCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _pinCode;
  bool again = false;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dim().d16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: Dim().d120,
              ),
              Text(
                'OTP Verfication',
                style: nunitaSty().extraLargeText.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
              SizedBox(
                height: Dim().d40,
              ),
              RichText(
                  text: TextSpan(
                      text: "Enter the OTP send on ",
                      style: nunitaSty().smalltext.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                      children: [
                    TextSpan(
                      text: '+91 ${widget.sMobile}',
                      style: nunitaSty().smalltext.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                    ),
                  ])),
              SizedBox(
                height: Dim().d12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dim().d24),
                child: PinCodeTextField(
                  controller: otpCtrl,
                  // errorAnimationController: errorController,
                  appContext: context,
                  enableActiveFill: true,
                  textStyle: nunitaSty().largeText,
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  cursorColor: Clr().primaryColor,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(Dim().d8),
                      fieldWidth: Dim().d60,
                      fieldHeight: Dim().d60,
                      selectedFillColor: Clr().grey.withOpacity(0.1),
                      activeFillColor: Clr().grey.withOpacity(0.1),
                      inactiveFillColor: Clr().grey.withOpacity(0.1),
                      borderWidth: 0.3,
                      inactiveColor: Clr().grey.withOpacity(0.1),
                      activeColor: Clr().primaryColor,
                      selectedColor: Clr().primaryColor,
                      activeBorderWidth: 0.2),
                  animationDuration: const Duration(milliseconds: 200),
                  onChanged: (value) {
                    _pinCode = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty || !RegExp(r'(.{4,})').hasMatch(value)) {
                      return 'Please enter a valid OTP';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: Dim().d8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    again == false
                        ? "Resend OTP in "
                        : "I didn't receive a code! ",
                    style: nunitaSty().smalltext.copyWith(
                          color: again == false
                              ? Clr().primaryColor
                              : Theme.of(ctx).colorScheme.primary,
                          fontWeight: again == false
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                  ),
                  Visibility(
                    visible: !again,
                    child: TweenAnimationBuilder<Duration>(
                        duration: const Duration(seconds: 60),
                        tween: Tween(
                            begin: const Duration(seconds: 60),
                            end: Duration.zero),
                        onEnd: () {
                          // ignore: avoid_print
                          // print('Timer ended');
                          setState(() {
                            again = true;
                          });
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                          final minutes = value.inMinutes;
                          final seconds = value.inSeconds % 60;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "0$minutes:$seconds",
                              textAlign: TextAlign.center,
                              style: nunitaSty().smalltext.copyWith(
                                  color: Clr().primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        }),
                  ),
                  // Visibility(
                  //   visible: !isResend,
                  //   child: Text("I didn't receive a code! ${(  sTime  )}",
                  //       style: Sty().mediumText),
                  // ),
                  Visibility(
                    visible: again,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          again = false;
                        });
                        authapi().resendOTP(ctx, widget.sMobile);
                        // authApi().resndApiOTP(ctx, widget.sMobile, setState);
                      },
                      child: Text(
                        'Resend OTP',
                        style: nunitaSty().microText.copyWith(
                            color: const Color.fromARGB(255, 248, 42, 111),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dim().d20,
              ),
              AnimatedButton(
                color: Clr().primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(Dim().d2)),
                pressEvent: () {
                  STM().checkInternet(ctx, widget).then((value) {
                    if (value) {
                      if (_formKey.currentState!.validate()) {
                        authapi().verifyOtp(ctx, otpCtrl.text, widget.sMobile,
                            widget.type, setState);
                      }
                    }
                  });
                },
                text: 'Verify',
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
}
