import 'package:hk/homedirectory/home.dart';
import 'package:hk/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homedirectory/wallet.dart';

List requestArrayList = [];
var bookingdetails;
List statusList = [];

class requestAuthApi {
  void getallRequest(ctx, setState, {id}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print(sp.getString('userid'));
    var body = {
      'user_id': sp.getString('userid'),
    };
    var result = await STM().allApi(
      apiname: 'requests',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading',
      type: 'post',
    );
    if (result['error'] == false) {
      setState(() {
        requestArrayList = result['booking_array'];
      });
      if (id != null) {
        int pos = requestArrayList
            .indexWhere((e) => e['id'].toString() == id.toString());
      }
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void bookingDetails(ctx, setState, id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'id': id,
    };
    var result = await STM().allApi(
      apiname: 'booking_status',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading',
      type: 'post',
    );
    setState(() {
      bookingdetails = result;
    });
    statusList.clear();
    for (int a = 0; a < result['track_array'].length; a++) {
      if (result['track_array'][a]['date'] != "") {
        setState(() {
          statusList.add(result['track_array'][a]['status']);
        });
      }
    }
    print(statusList);
  }

  void cancelBooking(ctx, setState, id, reason) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'id': id,
      'reason': reason,
    };
    var result = await STM().allApi(
      apiname: 'cancel_booking',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Cancelling',
      type: 'post',
    );
    if (result['error'] == false) {
      STM().successsDialogWithAffinity(ctx, result['message'], const Home());
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void getOTP(ctx, setState, type, id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'type': type,
      'booking_id': id,
    };
    var result = await STM().allApi(
      apiname: 'get_otp',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Getting',
      type: 'post',
    );
    if (result['error'] == false) {
      STM().displayToast(result['message']);
      bookingDetails(ctx, setState, id);
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void paymentApi(ctx, setState, id, amount) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'user_id': sp.getString('userid'),
      'id': id,
      'amount': amount,
    };
    var result = await STM().allApi(
      apiname: 'wallet_payment',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Processing',
      type: 'post',
    );
    if (result['error'] == false) {
      STM().successsDialogWithAffinity(ctx, result['message'], const Home());
    } else {
      STM().errorDialogWithReplace(ctx, result['message'], const walletPage());
    }
  }
}
