import 'package:hk/manage/static_method.dart';

List sliderList = [];
List serviceArryList = [];
List videoList = [];
List faqList = [];
var checkUserStaus, checkUpdate;

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
      });
    } else {
      STM().errorDialog(ctx, result['message']);
    }
  }
}
