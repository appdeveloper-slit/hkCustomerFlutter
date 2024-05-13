import 'package:hk/homedirectory/home.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/profilelayout/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var profileData;

class profileApi {
  void getProfile(ctx, setState) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      'user_id': sp.getString('userid'),
    };
    var result = await STM().allApi(
      apiname: 'get_profile',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Loading',
      type: 'post',
    );
    setState(() {
      profileData = result;
      print(profileData);
    });
  }

  void updateProfile(ctx, setState, list) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = {
      "user_id": sp.getString('userid'),
      "name": list[0],
      "email": list[1],
      "gender": list[2],
      "dob": list[3],
      "address": list[4],
      "locality": list[5],
      "latitude": list[6],
      "longitude": list[7],
    };
    var result = await STM().allApi(
      apiname: 'update_profile',
      body: body,
      ctx: ctx,
      load: true,
      loadtitle: 'Uploading',
      type: 'post',
    );
    if (result['error'] == false) {
      STM().displayToast(result['message']);
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
