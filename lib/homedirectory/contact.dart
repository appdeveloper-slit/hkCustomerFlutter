import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hk/manage/static_method.dart';
import 'package:hk/values/colors.dart';
import 'package:hk/values/dimens.dart';
import 'package:hk/values/styles.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUsPage extends StatefulWidget {
  const contactUsPage({super.key});

  @override
  State<contactUsPage> createState() => _contactUsPageState();
}

class _contactUsPageState extends State<contactUsPage> {
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
          'Contact Us',
          style: nunitaSty().extraLargeText.copyWith(
                color: Theme.of(ctx).colorScheme.primary == Clr().black
                    ? Clr().primaryColor
                    : Theme.of(ctx).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '== Mobile ==',
              style: nunitaSty().mediumText.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  STM().openDialer('9137417075');
                });
              },
              child: Text(
                '9137417075',
                style: nunitaSty().smalltext.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Text(
              '== Email ==',
              style: nunitaSty().mediumText.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
            ),
            InkWell(
              onTap: () async {
                await launch('mailto:nhkhcs17@gmail.com');
              },
              child: Text(
                'nhkhcs17@gmail.com',
                style: nunitaSty().smalltext.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
            SizedBox(
              height: Dim().d20,
            ),
            Text(
              '== Address ==',
              style: nunitaSty().mediumText.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(ctx).colorScheme.primary,
                  ),
            ),
            InkWell(
              onTap: () async {
                MapsLauncher.launchQuery(
                    'HARE KRISHNA WH CARE SERVICES.LLP\nSanta Dnyaneshwar C.H.S., Opp. Jogani Industrial Gate No. 2 Cementry Road, Panchansheel Nagar, Chunabhatti, Sion, Mumbai-22');
              },
              child: Text(
                '\nHARE KRISHNA WH CARE SERVICES.LLP\nSanta Dnyaneshwar C.H.S., Opp. Jogani Industrial Gate No. 2 Cementry Road, Panchansheel Nagar, Chunabhatti, Sion, Mumbai-22',
                textAlign: TextAlign.center,
                style: nunitaSty().smalltext.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(ctx).colorScheme.primary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
