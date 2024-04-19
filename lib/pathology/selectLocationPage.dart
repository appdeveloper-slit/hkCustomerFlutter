// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:shared_preferences/shared_preferences.dart';
import '../manage/static_method.dart';
import 'slotsSelectionPage.dart';

List<Placemark> addressList = [];
String? mapLoc, Slat, slng;

class locationPage extends StatefulWidget {
  const locationPage({super.key});

  @override
  State<locationPage> createState() => _locationPageState();
}

class _locationPageState extends State<locationPage> {
  late BuildContext ctx;

  bool checkLoader = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getTokken();
    });
    super.initState();
  }

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
          'Select Location',
          style: nunitaSty().extraLargeText.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dim().d20, vertical: Dim().d20),
        child: checkLoader
            ? Center(
                child: CircularProgressIndicator(
                  color: Clr().primaryColor,
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Map Location',
                      style: nunitaSty().mediumText.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(ctx).colorScheme.primary,
                          ),
                    ),
                    SizedBox(
                      height: Dim().d20,
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
                        if (mapLoc == null) {
                          return 'Please enter a Address';
                        }
                      },
                    ),
                    SizedBox(
                      height: Dim().d20,
                    ),
                    SizedBox(
                      height: Dim().d40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Clr().primaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            checkServiceApi();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: nunitaSty()
                              .mediumBoldText
                              .copyWith(color: Clr().white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void getTokken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = await STM().pathologyApi(
      apiname: 'getAccessToken',
      type: 'get',
      ctx: ctx,
      load: true,
      loadtitle: 'Fetching Token...',
    );
    if (result['success'] == true) {
      setState(() {
        print(result['access_token']);
        sp.setString('pathotoken', result['access_token']);
        checkLoader = false;
      });
    } else {
      STM().errorDialogWithinffinity(ctx, result['message'], const Home());
    }
  }

  void checkServiceApi() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    addressList = await placemarkFromCoordinates(
      double.parse(Slat.toString()),
      double.parse(slng.toString()),
    );
    var body = {
      "zipcode": addressList[0].postalCode ?? addressList[1].postalCode,
      "lat": Slat,
      "long": slng,
    };
    print(body);
    var result = await STM().pathologyApi(
      ctx: ctx,
      apiname: 'checkServiceabilityByLocation',
      body: body,
      load: true,
      loadtitle: 'Checking...',
      type: 'post',
      token: sp.getString('pathotoken'),
    );
    if (result['status'] == true) {
      setState(() {
        sp.setString(
          'pathZipcode',
          addressList[0].postalCode.toString(),
        );
        sp.setString(
          'lat',
          Slat.toString(),
        );
        sp.setString(
          'lng',
          slng.toString(),
        );
      });
      STM().redirect2page(ctx, const slotsSelectionPage());
      // STM().displayToast(result['message']);
    } else {
      // ignore: prefer_const_constructors
      AwesomeDialog(
        context: ctx,
        dialogBackgroundColor: Clr().white,
        dialogType: DialogType.noHeader,
        body: Padding(
          padding: EdgeInsets.all(Dim().d20),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/loc.svg',
                height: Dim().d240,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: Dim().d12,
              ),
              Text(
                "Oops! It appears that our service isn't offered in the area you entered. Please input another location within our service range.",
                textAlign: TextAlign.center,
                style: nunitaSty().mediumText,
              ),
              SizedBox(
                height: Dim().d20,
              ),
              SizedBox(
                height: Dim().d40,
                width: Dim().d220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Clr().primaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () {
                    STM().back2Previous(ctx);
                  },
                  child: Text(
                    'OK',
                    style: nunitaSty().mediumText.copyWith(
                          color: Clr().white,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ).show();
    }
  }
}
