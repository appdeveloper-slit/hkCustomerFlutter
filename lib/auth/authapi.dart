import 'package:hk/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homedirectory/home.dart';
import 'registerdetail.dart';
import 'verification.dart';

class authapi {
  void sendOTPApi(ctx, num, type) async {
    var body = {
      'page_type': 'register',
      'mobile': num,
    };
    var result = await STM().allApi(
      apiname: 'sendOTP',
      type: 'post',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Processing',
    );
    if (result['error'] == false) {
      STM().redirect2page(
          ctx,
          verificationPage(
            sMobile: num,
            type: type,
          ));
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void resendOTP(ctx, num) async {
    var body = {
      'mobile': num,
    };
    var result = await STM().allApi(
        apiname: 'resendOTP',
        type: 'post',
        body: body,
        ctx: ctx,
        load: true,
        loadtitle: 'Sending OTP');
    if (result['error'] == false) {
      STM().displayToast(result['message']);
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void verifyOtp(ctx, otp, num, type, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'page_type': type,
      'otp': otp,
      'mobile': num,
    };
    var result = await STM().allApi(
        apiname: 'verifyOTP',
        type: 'post',
        body: body,
        ctx: ctx,
        load: true,
        loadtitle: 'Verifying');
    if (result['error'] == false) {
      if (type == 'login') {
        setState(() {
          sp.setBool('login', true);
          sp.setString('userid', result['user_id'].toString());
          STM().finishAffinity(ctx, const Home());
        });
      }
      STM().redirect2page(
          ctx,
          registerdetailPage(
            mobile: num,
          ));
      STM().displayToast(result['message']);
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void resgisterAuth(ctx, setState, data) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "name": data[0],
      "mobile": data[1],
      "email": data[2],
      "gender": data[3],
      "dob": data[4],
      "address": data[5],
      "location": data[6],
      "latitude": data[7],
      "longitude": data[8],
    };
    print(body);
    var result = await STM().allApi(
      apiname: 'signup',
      type: 'post',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Processing...',
    );
    if (result['error'] == false) {
      setState(() {
        sp.setBool('login', true);
        sp.setString('userid', result['user_id'].toString());
        STM().successsDialogWithAffinity(ctx, result['message'], Home());
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
