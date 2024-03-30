import 'package:flutter/material.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late BuildContext ctx;
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
          'About Us',
          style: nunitaSty().smalltext.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Dim().d12),
        child: Column(
          children: [
            SizedBox(
              height: Dim().d12,
            ),
            Align(
              child: Image.asset(
                'assets/applogo.png',
                height: Dim().d100,
                width: Dim().d100,
              ),
            ),
            SizedBox(
              height: Dim().d8,
            ),
            Text(
              'H.K.Healthcare',
              style: nunitaSty().mediumBoldText.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
            ),
            SizedBox(
              height: Dim().d28,
            ),
            Text(
              "WELCOME TO HAREKRISHNA WH CARE SERVICES\n\nHEALING HANDS CARING HEARTS\n\nHAREKRISHNA WH CARE SERVICES is established on 26th January 2017.\nISO Certified 9001–2015.\nWe are working for providing services like Nursing care, adult care, caregiver, Physiotherapy, Occupational therapy, Speech therapy,  Dietitian and Nutritionist, Doctors, and Yoga therapy. HAREKRISHNA WH CARE SERVICES frequently work in groups with other well being experts to assist with meeting a caregiving services.\n\n\nOur Values Mission\nWe focus on giving quality and inventive consideration by encouraging an agreeable, private and expert climate.\n\n\nVision\nTo be the leading association in advancing the active recuperation calling in India to the most elevated level and safeguard the actual specialist\'s privileges driven by brilliant outcomes and an educated, agreeable and proficient staff.\n\nImmediate Goal\n• Quality - the underpinning of proof-based, entire patient care services\n• Integrity - the underpinning of trust and validness\n\n\nOur Mission\nWe focus on giving quality and inventive consideration by encouraging an agreeable, private and expert climate.\n\n\nSERVICES\nWe are a group of inventive, sympathetic, commendable healthcare services experts driven by energy, motivation, and execution as we care for our clients from each age, stage, and social status.\n\nWE PROVIDE HIGH QUALITY, INDIVIDUALIZED CARE FOR PATIENTS OF ALL AGES WHERE YOU FEEL MOST COMFORTABLE – YOUR HOME, hospitals, COMMUNITY or at workplace. OUR SERVICES AND EQUIPMENT ARE DESIGNED TO HELP YOU REGAIN AND RETAIN A LEVEL OF INDEPENDENCE.",
              style: nunitaSty().microText.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
