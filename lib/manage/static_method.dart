import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../values/colors.dart';
import '../values/dimens.dart';
import '../values/styles.dart';
import 'app_url.dart';

class STM {
  Route _createRoute(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void redirect2page(BuildContext context, Widget widget) {
    Navigator.push(context, _createRoute(widget));
  }

  void replacePage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(context, _createRoute(widget));
  }

  void back2Previous(BuildContext context) {
    Navigator.pop(context);
  }

  void displayToast(String string) {
    Fluttertoast.showToast(msg: string, toastLength: Toast.LENGTH_SHORT);
  }

  void displaySearchToast(String string) {
    Fluttertoast.showToast(
        msg: string,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  openWeb(String url) async {
    await launchUrl(Uri.parse(url.toString()));
  }

  void finishAffinity(final BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      _createRoute(widget),
      (Route<dynamic> route) => false,
    );
  }

  void successsDialog(context, message, widget) {
    AwesomeDialog(
            dialogBackgroundColor: Clr().white,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'successs',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget),
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  AwesomeDialog successsWithButton(context, message, function) {
    return AwesomeDialog(
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        title: 'successs',
        desc: message,
        btnOkText: "OK",
        btnOkOnPress: function,
        btnOkColor: Clr().successGreen);
  }

  void successsDialogWithAffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dialogBackgroundColor: Clr().white,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'successs',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  void successsDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dialogBackgroundColor: Clr().white,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'successs',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().successGreen)
        .show();
  }

  void errorDialog(BuildContext context, String message) {
    AwesomeDialog(
        dialogBackgroundColor: Theme.of(context).colorScheme.background,
        context: context,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        dialogType: DialogType.noHeader,
        animType: AnimType.scale,
        headerAnimationLoop: true,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Error',
                  textAlign: TextAlign.left,
                  style: nunitaSty().mediumText.copyWith(
                      color: Clr().errorRed, fontWeight: FontWeight.w600)),
              SizedBox(
                height: Dim().d8,
              ),
              Text(message,
                  style: nunitaSty()
                      .smalltext
                      .copyWith(color: Theme.of(context).colorScheme.primary)),
              SizedBox(
                height: Dim().d16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                    onTap: () {
                      STM().back2Previous(context);
                    },
                    child: Text(
                      'ok',
                      style: nunitaSty().smalltext.copyWith(
                          color: Clr().primaryColor,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.right,
                    )),
              ),
              SizedBox(
                height: Dim().d16,
              ),
            ],
          ),
        )).show();
  }

  void errorDialogWithReplace(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => widget,
                ),
              );
            },
            btnOkColor: Clr().errorRed)
        .show();
  }

  void errorDialogWithinffinity(
      BuildContext context, String message, Widget widget) {
    AwesomeDialog(
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.scale,
            headerAnimationLoop: true,
            title: 'Note',
            desc: message,
            btnOkText: "OK",
            btnOkOnPress: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      widget,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.fastOutSlowIn;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            btnOkColor: Clr().blue)
        .show();
  }

  AwesomeDialog loadingDialog(BuildContext context, String title) {
    AwesomeDialog dialog = AwesomeDialog(
      dialogBackgroundColor: Clr().white,
      width: 250,
      context: context,
      dismissOnBackKeyPress: true,
      dismissOnTouchOutside: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: WillPopScope(
        onWillPop: () async {
          displayToast('Something went wrong try again.');
          return true;
        },
        child: Container(
          height: Dim().d160,
          padding: EdgeInsets.all(Dim().d16),
          decoration: BoxDecoration(
            color: Clr().white,
            borderRadius: BorderRadius.circular(Dim().d32),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(Dim().d12),
                child: SpinKitRing(
                  lineWidth: 5.0,
                  color: Clr().primaryColor,
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(Dim().d4),
              //   child:Lottie.asset('animation/ShrmaAnimation.json',height: 90,
              //       fit: BoxFit.cover),
              // ),
              // SizedBox(
              //   height: Dim().d16,
              // ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: nunitaSty().mediumBoldText,
              ),
            ],
          ),
        ),
      ),
    );
    return dialog;
  }

  /// Date Picker
  Future<String> datePicker(ctx) async {
    DateTime? picked = await showDatePicker(
      context: ctx,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(primary: Clr().primaryColor),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return STM().dateFormat('yyyy-MM-dd', picked);
  }

  Widget sb({
    double? h,
    double? w,
  }) {
    return SizedBox(
      height: h,
      width: w,
    );
  }

  void alertDialog(context, message, widget) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        AlertDialog dialog = AlertDialog(
          title: Text(
            "Confirmation",
            style: nunitaSty().largeText,
          ),
          content: Text(
            message,
            style: nunitaSty().smalltext,
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {},
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        return dialog;
      },
    );
  }

  AwesomeDialog modalDialog(context, widget, color) {
    AwesomeDialog dialog = AwesomeDialog(
      dialogBackgroundColor: color,
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      body: widget,
    );
    return dialog;
  }

  void mapDialog(BuildContext context, Widget widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      padding: EdgeInsets.zero,
      animType: AnimType.scale,
      body: widget,
      btnOkText: 'Done',
      btnOkColor: Clr().successGreen,
      btnOkOnPress: () {},
    ).show();
  }

  Widget setSVG(name, size, color) {
    return SvgPicture.asset(
      'assets/$name.svg',
      height: size,
      width: size,
      color: color,
    );
  }

  Widget emptyData(message) {
    return Center(
      child: Text(
        message,
        style: nunitaSty().smalltext.copyWith(
              color: Clr().primaryColor,
              fontSize: 18.0,
            ),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomList(index, b) {
    return [
      BottomNavigationBarItem(
        icon: b
            ? SvgPicture.asset(
                "assets/bn_home.svg",
              )
            : index == 0
                ? SvgPicture.asset(
                    "assets/bn_home_fill.svg",
                    // color: index == 0 ? Clr().primaryColor : Clr().white,
                  )
                : SvgPicture.asset(
                    "assets/bn_home.svg",
                  ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: index == 1
            ? SvgPicture.asset(
                "assets/bn_category_fill.svg",
                // color: index == 1 ? Clr().white : null,
              )
            : SvgPicture.asset(
                "assets/bn_category.svg",
              ),
        label: 'My Loans',
      ),
      BottomNavigationBarItem(
        icon: index == 2
            ? SvgPicture.asset(
                "assets/bn_investment_fill.svg",
              )
            : SvgPicture.asset(
                "assets/bn_investment.svg",
              ),
        label: 'Investment',
      ),
      BottomNavigationBarItem(
        icon: index == 3
            ? SvgPicture.asset(
                "assets/bn_profile_fill.svg",
              )
            : SvgPicture.asset(
                "assets/bn_profile.svg",
              ),
        label: 'Profile',
      ),
    ];
  }

  firstBar(index, ctx) {
    return index == 0
        ? InkWell(
            onTap: () {
              // STM().finishAffinity(ctx, Home());
            },
            child: Image.asset('assets/home_icon.png', height: Dim().d52))
        : InkWell(
            onTap: () {
              // STM().finishAffinity(ctx, Home());
            },
            child: SvgPicture.asset('assets/home.svg'));
  }

  secondBar(index, ctx) {
    return index == 1
        ? InkWell(
            onTap: () {
              // STM().replacePage(ctx, SearchPage());
            },
            child: Image.asset('assets/search_icon.png', height: Dim().d52))
        : InkWell(
            onTap: () {
              // STM().redirect2page(ctx, SearchPage());
            },
            child: SvgPicture.asset('assets/search.svg'));
  }

  thirdBar(index, ctx) {
    return index == 2
        ? InkWell(
            onTap: () {
              // STM().replacePage(ctx, CategoryPage());
            },
            child: Image.asset('assets/center.png', height: Dim().d52))
        : InkWell(
            onTap: () {
              // STM().replacePage(ctx, CategoryPage());
            },
            child: SvgPicture.asset('assets/center.svg'));
  }

  fourthBar(index, ctx) {
    return index == 3
        ? InkWell(
            onTap: () {
              // STM().replacePage(ctx, MyAlbumsPage());
            },
            child: Image.asset('assets/collection_icon.png', height: Dim().d52))
        : InkWell(
            onTap: () {
              // STM().redirect2page(ctx, MyAlbumsPage());
            },
            child: SvgPicture.asset('assets/collection.svg'));
  }

  fiveBar(index, ctx) {
    return index == 4
        ? InkWell(
            onTap: () {
              // STM().redirect2page(ctx, accountPage());
            },
            child: Image.asset('assets/percon.png', height: Dim().d52))
        : InkWell(
            onTap: () {
              // STM().redirect2page(ctx, accountPage());
            },
            child: SvgPicture.asset('assets/percon.svg'));
  }

  buttonBar(index, ctx) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: Dim().d72 - 3,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dim().d20)),
            image: const DecorationImage(
                image: AssetImage('assets/bottom.jpg'), fit: BoxFit.fitWidth)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            firstBar(index, ctx),
            secondBar(index, ctx),
            thirdBar(index, ctx),
            fourthBar(index, ctx),
            fiveBar(index, ctx),
          ],
        ),
      ),
    );
  }

  //Dialer
  Future<void> openDialer(String phoneNumber) async {
    Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(Uri.parse(launchUri.toString()));
  }

  //WhatsApp
  Future<void> openWhatsApp(String phoneNumber) async {
    await launchUrl(Uri.parse("https://wa.me/$phoneNumber"));
    // if (Platform.isIOS) {
    //   await launchUrl(Uri.parse("whatsapp:wa.me/$phoneNumber"));
    // } else {
    //   await launchUrl(Uri.parse("whatsapp:send?phone=$phoneNumber"));
    // }
  }

  Future<bool> checkInternet(context, widget) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      internetAlert(context, widget);
      return false;
    }
  }

  internetAlert(context, widget) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      body: Padding(
        padding: EdgeInsets.all(Dim().d20),
        child: Column(
          children: [
            // SizedBox(child: Lottie.asset('assets/no_internet_alert.json')),
            Text(
              'Connection Error',
              style: nunitaSty().largeText.copyWith(
                    color: Clr().primaryColor,
                    fontSize: 18.0,
                  ),
            ),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'No Internet connection found.',
              style: nunitaSty().smalltext,
            ),
            SizedBox(
              height: Dim().d32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: nunitaSty().primaryButton,
                onPressed: () async {
                  var connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    Navigator.pop(context);
                    STM().replacePage(context, widget);
                  }
                },
                child: Text(
                  "Try Again",
                  style: nunitaSty().largeText.copyWith(
                        color: Clr().white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ).show();
  }

  String dateFormat(format, date) {
    return DateFormat(format).format(date).toString();
  }

  Future<bool?> showToast(title) {
    return Fluttertoast.showToast(
        msg: title,
        backgroundColor: Clr().red,
        gravity: ToastGravity.BOTTOM,
        textColor: Clr().white,
        toastLength: Toast.LENGTH_LONG);
  }

  Future<dynamic> allApi(
      {ctx,
      Map<String, dynamic>? body,
      apiname,
      type,
      token,
      bool? load,
      loadtitle,
      apitype}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    AwesomeDialog dialog = STM().loadingDialog(ctx, loadtitle);
    load == true ? dialog.show() : null;
    String url = AppUrl.mainUrl + apiname;
    String url1 = 'https://api.emptra.com/$apiname';
    var headers = {
      "Content-Type": "application/json",
      "responseType": "ResponseType.plain",
    };

    dynamic result;
    try {
      final response = type == 'post'
          ? await http.post(
              Uri.parse(apitype == 'checkKyc' ? url1 : url),
              body: json.encode(body),
              headers: headers,
            )
          : await http.get(
              Uri.parse(url),
              headers: headers,
            );
      if (response.statusCode == 200) {
        print(response.body);
        try {
          load == true ? dialog.dismiss() : null;
          result = json.decode(response.body.toString());
        } catch (_) {
          load == true ? dialog.dismiss() : null;
          result = response.body;
        }
      } else if (response.statusCode == 500) {
        load == true ? dialog.dismiss() : null;
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred in $apiname');
      } else if (response.statusCode == 401) {
        load == true ? dialog.dismiss() : null;
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred in $apiname');
      } else {
        load == true ? dialog.dismiss() : null;
        STM().errorDialog(ctx,
            'Something went wrong on the server side. Please try again later ${response.statusCode} Occurred  in $apiname');
      }
    } catch (e) {
      load == true ? dialog.dismiss() : null;
      if (e is TimeoutException) {
        showToast('TimeOut!!!,Please try again');
      } else if (e is CertificateException) {
        showToast(
            'CertificateException!!! SSL not verified while fetching data from $apiname');
      } else if (e is HandshakeException) {
        showToast(
            'HandshakeException!!! Connection not secure while fetching data from $apiname');
      } else if (e is FormatException) {
        showToast(
            'FormatException!!! Data cannot parse and unexpected format while fetching data from $apiname');
      } else {
        showToast('Something went wrong in $apiname');
      }
    }
    return result;
  }

  Widget loadingPlaceHolder() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 0.6,
        color: Clr().primaryColor,
      ),
    );
  }

  Widget imageView(Map<String, dynamic> v) {
    return v['url'].toString().contains('assets')
        ? Image.asset(
            '${v['url']}',
            width: v['width'],
            height: v['height'],
            fit: v['fit'] ?? BoxFit.fill,
          )
        : CachedNetworkImage(
            width: v['width'],
            height: v['height'],
            fit: v['fit'] ?? BoxFit.fill,
            imageUrl: v['url'] ??
                'https://www.famunews.com/wp-content/themes/newsgamer/images/dummy.png',
            placeholder: (context, url) => STM().loadingPlaceHolder(),
          );
  }

  CachedNetworkImage networkimg(url) {
    return url == null
        ? CachedNetworkImage(
            imageUrl:
                'https://liftlearning.com/wp-content/uploads/2020/09/default-image.png',
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Clr().lightGrey),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: '$url',
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) => Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                // borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
          );
  }

  textLayout({firstText, secondText}) {
    if (secondText != null) {
      try {
        return firstText;
      } catch (_) {
        return secondText;
      }
    }
  }

  imageChecks(imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return SvgPicture.network(
        imageUrl,
        fit: BoxFit.cover,
        height: Dim().d40,
        width: Dim().d40,
      );
    } else {
      return Image.network(
        'https://daluscapital.com/wp-content/uploads/2016/04/dummy-post-square-1-1.jpg',
        fit: BoxFit.cover,
        height: Dim().d40,
        width: Dim().d40,
      );
    }
  }
}
