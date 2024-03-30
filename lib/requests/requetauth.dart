import 'package:hk/manage/static_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

List requestArrayList = [];
var bookingdetails;
List statusList = [];

class requestAuthApi {
  void getallRequest(ctx, setState) async {
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
    for (int a = 0; a < result['track_array'].length; a++) {
      if (result['track_array'][a]['date'] != "") {
        setState(() {
          statusList.add(result['track_array'][a]['status']);
        });
      }
    }
  }
}
