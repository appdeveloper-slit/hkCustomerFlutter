import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/homedirectory/homeapi.dart';
import 'package:hk/values/dimens.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../manage/static_method.dart';
import '../values/colors.dart';
import '../values/styles.dart';

class walletPage extends StatefulWidget {
  const walletPage({super.key});

  @override
  State<walletPage> createState() => _walletPageState();
}

class _walletPageState extends State<walletPage> {
  late BuildContext ctx;
  var _razorpay = Razorpay();
  TextEditingController _amtCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration.zero,
      () {
        homeApiAuth().walletHistryApi(ctx, setState);
      },
    );
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    STM().successsDialogWithReplace(ctx, 'Payment Successful😀', widget);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    STM().errorDialog(ctx, '${response.message.toString()}😌');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        elevation: 1,
        leading: InkWell(
          onTap: () {
            STM().back2Previous(ctx);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(ctx).colorScheme.primary == Clr().black
                ? Clr().primaryColor
                : Theme.of(ctx).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          'My Wallet',
          style: nunitaSty().extraLargeText.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Dim().d20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Available Balance',
                style: nunitaSty().mediumText.copyWith(
                      color: Theme.of(ctx).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/wallet.svg',
                  width: Dim().d24,
                  color: Theme.of(ctx).colorScheme.primary == Clr().white
                      ? Clr().white
                      : Clr().primaryColor,
                ),
                SizedBox(
                  width: Dim().d12,
                ),
                Text(
                  '₹ $balance',
                  style: nunitaSty().mediumText.copyWith(
                        color: Theme.of(ctx).colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: Dim().d12,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: Dim().d40,
                width: Dim().d240,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Clr().primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          backgroundColor: Theme.of(ctx).colorScheme.background,
                          title: Text(
                            'Recharge',
                            textAlign: TextAlign.center,
                            style: nunitaSty().extraLargeText.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(ctx).colorScheme.primary,
                                ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter Amount',
                                textAlign: TextAlign.center,
                                style: nunitaSty().smalltext.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(ctx).colorScheme.primary,
                                    ),
                              ),
                              TextFormField(
                                controller: _amtCtrl,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                decoration: nunitaSty()
                                    .TextFormFieldOutlineDarkStyle
                                    .copyWith(
                                        hintText: 'Enter Amount',
                                        hintStyle:
                                            nunitaSty().microText.copyWith(
                                                  color: Clr().hintColor,
                                                )),
                              ),
                              SizedBox(
                                height: Dim().d12,
                              ),
                              SizedBox(
                                height: Dim().d44,
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Clr().primaryColor,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_amtCtrl.text.isNotEmpty) {
                                        setState(() {
                                          var long2 =
                                              double.parse(_amtCtrl.text);
                                          var price = long2 * 100;
                                          var options = {
                                            'key': 'rzp_live_tZeYuzKH4GTGPf',
                                            'amount': '${price.toString()}',
                                            'name': 'Health Care',
                                            'order': {
                                              "id": "order_DaZlswtdcn9UNV",
                                              "entity": "order",
                                              "amount": '${price.toString()}',
                                              "amount_paid": 0,
                                              "amount_due":
                                                  '${price.toString()}',
                                              "currency": "INR",
                                              "status": "created",
                                              "attempts": 0,
                                            },
                                            'theme.color': '#7B2C82',
                                            'timeout': 900,
                                          };
                                          _razorpay.open(options);
                                        });
                                      } else {
                                        STM().displayToast(
                                            'Please insert a amount');
                                      }
                                    },
                                    child: Text(
                                      'Recharge',
                                      style: nunitaSty()
                                          .smalltext
                                          .copyWith(color: Clr().white),
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Recharge',
                    style: nunitaSty().mediumText.copyWith(
                          color: Clr().white,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Dim().d20),
              child: ListView.builder(
                itemCount: walletHList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: Dim().d20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(ctx).colorScheme.background,
                        border: Border.all(
                          color: Colors.black12,
                          width: 0.2,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Colors.black12,
                          )
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(Dim().d12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${walletHList[index]['txTime']}',
                                  style: nunitaSty().smalltext.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(ctx).colorScheme.primary ==
                                                    Clr().black
                                                ? const Color(0xffB2B2B2)
                                                : Clr().white,
                                      ),
                                ),
                                SizedBox(
                                  height: Dim().d4,
                                ),
                                Text(
                                  '${walletHList[index]['type']}',
                                  style: poppinsSty().smalltext.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(ctx).colorScheme.primary),
                                )
                              ],
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              '   :',
                            ),
                          ),
                          Expanded(
                              child: Text(
                            walletHList[index]['txn_type'] == 'Debit'
                                ? '- ₹${walletHList[index]['amount']}'
                                : '+ ₹${walletHList[index]['amount']}',
                            style: poppinsSty().smalltext.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color:
                                      walletHList[index]['txn_type'] == 'Debit'
                                          ? Clr().red
                                          : Clr().green,
                                ),
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
