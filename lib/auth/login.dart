import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  late BuildContext ctx;
  TextEditingController _mobileCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? checkTooltip;
  String? value;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Clr().background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dim().d20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dim().d100,
              ),
              Align(
                alignment: Alignment.center,
                child: Text('Welcome Back',
                    textAlign: TextAlign.center,
                    style: nunitaSty()
                        .extraLargeText
                        .copyWith(fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: Dim().d40,
              ),
              Text('Mobile Number',
                  style: nunitaSty()
                      .mediumText
                      .copyWith(fontWeight: FontWeight.w400)),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: _mobileCtrl,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: nunitaSty().mediumText,
                decoration: nunitaSty().TextFormFieldOutlineDarkStyle.copyWith(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(Dim().d16),
                        child: SvgPicture.asset(
                          'assets/call.svg',
                        ),
                      ),
                      hintText: 'Enter Your Number',
                      hintStyle: nunitaSty().smalltext.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Clr().hintColor,
                          ),
                      suffixIcon: checkTooltip == true
                          ? Tooltip(
                              message: value ?? '',
                              triggerMode: TooltipTriggerMode.tap,
                              decoration: BoxDecoration(
                                color: Clr().black,
                              ),
                              child: Icon(
                                Icons.error,
                                color: Clr().red,
                              ),
                            )
                          : Container(
                              width: 0,
                            ),
                    ),
                validator: (value) {
                  if (value!.isEmpty) {
                    setState(() {
                      checkTooltip = true;
                      value = 'Please enter a phone number';
                    });
                  }
                  if (value!.length != 10) {
                    setState(() {
                      checkTooltip = true;
                      value = 'Please enter a valid phone number';
                    });
                  }
                  return null;
                },
              ),
              SizedBox(
                height: Dim().d32,
              ),
              AnimatedButton(
                color: Clr().primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(Dim().d4)),
                pressEvent: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: 'Sign In',
                buttonTextStyle: nunitaSty().mediumText.copyWith(
                      color: Clr().white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: Dim().d12,
              ),
              Align(
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                        text: 'Don’t have an account? ',
                        style: poppinsSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                        children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: nunitaSty().smalltext.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Clr().secondary,
                            ),
                      )
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
