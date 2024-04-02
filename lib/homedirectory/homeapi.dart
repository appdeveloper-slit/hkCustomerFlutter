import 'package:hk/homedirectory/home.dart';
import 'package:hk/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

List sliderList = [];
List serviceArryList = [];
List videoList = [];
List faqList = [];
List tipsList = [];
List notiList = [];
var checkUserStaus, checkUpdate;
var balance;
List walletHList = [];

class homeApiAuth {
  void homeApi(ctx, setState, list) async {
    var body = {
      "uuid": list[0],
      "user_id": list[1],
      "date": list[2],
    };
    var result = await STM().allApi(
      apiname: 'home',
      ctx: ctx,
      body: body,
      load: true,
      loadtitle: 'Loading...',
      type: 'post',
    );
    if (result['error'] == false) {
      setState(() {
        sliderList = result['slider_array'];
        serviceArryList = result['service_array'];
        videoList = result['testimonials_array'];
        faqList = result['faqs_array'];
        checkUserStaus = result['is_active'];
        checkUpdate = result['update_type'];
        tipsList = result['tips_array'];
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void notificationAuthApi(ctx, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "user_id": sp.getString('userid'),
    };
    var result = await STM().allApi(
      apiname: 'notification',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading',
      type: 'post',
    );
    if (result['error'] == true) {
      setState(() {
        notiList = result['result_array'];
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void bookingrequest(ctx, setState, id) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "user_id": sp.getString('userid'),
      "id": id,
    };
    var result = await STM().allApi(
      apiname: 'submit_request',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Processing',
      type: 'post',
    );
    if (result['error'] == false) {
      STM().successsDialogWithAffinity(ctx, result['message'], const Home());
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }

  void walletHistryApi(ctx, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "user_id": sp.getString('userid'),
    };
    var result = await STM().allApi(
      apiname: 'wallet_history',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading',
      type: 'post',
    );
    if (result['error'] == false) {
      setState(() {
        walletHList = result['result_array'];
        balance = result['balance'];
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
