import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/auth/login.dart';
import 'package:hk/homedirectory/contact.dart';
import 'package:hk/homedirectory/home.dart';
import 'package:hk/homedirectory/wallet.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/profilelayout/profilepage.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../requests/request.dart';
import '../values/colors.dart';
import 'aboutus.dart';

Widget drawerLayout({scaffoldState, setState, ctx, userExits}) {
  return SafeArea(
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Drawer(
        width: MediaQuery.of(ctx).size.width * 0.64,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(ctx).colorScheme.background),
          child: WillPopScope(
            onWillPop: () async {
              closeDrawer(ctx, null, scaffoldState, null, setState);
              return true;
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Dim().d20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/applogo.png',
                    height: Dim().d120,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                    vertical: Dim().d28,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        closeDrawer(
                            ctx, const Home(), scaffoldState, null, setState);
                      });
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/home.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Home',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (userExits != null) {
                        STM().redirect2page(ctx, const profileLayPage());
                      } else {
                        STM().redirect2page(ctx, const loginPage());
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/profile.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'My Profile',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                    vertical: Dim().d28,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (userExits != null) {
                        STM().redirect2page(ctx, const walletPage());
                      } else {
                        STM().redirect2page(ctx, const loginPage());
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/wallet.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'My Wallet',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (userExits != null) {
                        STM().redirect2page(ctx, const requestPage());
                      } else {
                        STM().redirect2page(ctx, const loginPage());
                      }
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/request.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'My Request',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                    vertical: Dim().d28,
                  ),
                  child: InkWell(
                    onTap: () {
                      closeDrawer(ctx, null, scaffoldState,
                          'https://hkwhcs.in/privacy_policy', setState);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/privacy.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Privacy Policy',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                  ),
                  child: InkWell(
                    onTap: () {
                      closeDrawer(ctx, null, scaffoldState,
                          'https://hkwhcs.in/terms', setState);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/terms.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Terms &\nConditions',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                    vertical: Dim().d28,
                  ),
                  child: InkWell(
                    onTap: () {
                      closeDrawer(ctx, null, scaffoldState,
                          'https://hkwhcs.in/refund', setState);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/refund.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Refund Policy',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                  ),
                  child: InkWell(
                    onTap: () {
                      Share.share(
                        'Download the H.K. Healthcare App\n\nDownload Link :\n https://play.google.com/store/apps/details?id=',
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/share.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Share App',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                    vertical: Dim().d28,
                  ),
                  child: InkWell(
                    onTap: () {
                      closeDrawer(ctx, const AboutUsPage(), scaffoldState, null,
                          setState);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/aboutus.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'About Us',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dim().d32,
                  ),
                  child: InkWell(
                    onTap: () {
                      closeDrawer(ctx, const contactUsPage(), scaffoldState,
                          null, setState);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/contactus.svg',
                          width: Dim().d24,
                          color:
                              Theme.of(ctx).colorScheme.primary == Clr().white
                                  ? Clr().white
                                  : Clr().primaryColor,
                        ),
                        SizedBox(
                          width: Dim().d20,
                        ),
                        Text(
                          'Contact Us',
                          style: nunitaSty().smalltext.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(ctx).colorScheme.primary,
                              ),
                        )
                      ],
                    ),
                  ),
                ),
                userExits != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dim().d32,
                          vertical: Dim().d28,
                        ),
                        child: InkWell(
                          onTap: () async {
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            setState(() {
                              sp.remove('login');
                              sp.remove('userid');
                              STM().finishAffinity(ctx, const loginPage());
                            });
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/logout.svg',
                                width: Dim().d24,
                                color: Theme.of(ctx).colorScheme.primary ==
                                        Clr().white
                                    ? Clr().white
                                    : Clr().primaryColor,
                              ),
                              SizedBox(
                                width: Dim().d20,
                              ),
                              Text(
                                'Log Out',
                                style: nunitaSty().smalltext.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(ctx).colorScheme.primary,
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

closeDrawer(ctx, widget, scaffoldState, link, setState) {
  if (scaffoldState.currentState!.isDrawerOpen) {
    setState(() {
      link != null
          ? STM().openWeb(link)
          : widget != null
              ? STM().redirect2page(ctx, widget)
              : null;
      scaffoldState.currentState!.openEndDrawer();
    });
  }
}
