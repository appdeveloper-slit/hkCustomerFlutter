import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(ctx).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(ctx).colorScheme.background,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dim().d16),
          child: SvgPicture.asset(
            'assets/menu.svg',
            fit: BoxFit.fitWidth,
            color: Theme.of(ctx).colorScheme.primary == Clr().white
                ? Clr().white
                : Clr().primaryColor,
          ),
        ),
        title: Image.asset(
          'assets/applogo.png',
          height: Dim().d40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dim().d16),
            child: SvgPicture.asset(
              'assets/Group.svg',
              fit: BoxFit.fitWidth,
              color: Theme.of(ctx).colorScheme.primary == Clr().white
                  ? Clr().white
                  : Clr().primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: Dim().d16),
            child: Icon(
              Icons.notifications_sharp,
              color: Theme.of(ctx).colorScheme.primary == Clr().white
                  ? Clr().white
                  : Clr().primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
