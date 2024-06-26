// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';

String name = 'nunita';
String name1 = 'poppins';

class nunitaSty {
  TextStyle smalltext = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 14.0,
  );

  TextStyle microText = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 12.0,
  );
  TextStyle mediumText = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 16.0,
  );
  TextStyle mediumBoldText = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle largeText = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle extraLargeText = TextStyle(
    fontFamily: name,
    letterSpacing: 0.5,
    fontSize: 20.0,
  );

  InputDecoration TextFormFieldUnderlineStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d12,
      vertical: Dim().d12,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().grey,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().primaryColor,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  InputDecoration TextFormFieldWithoutStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d14,
      vertical: Dim().d12,
    ),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    focusedErrorBorder: InputBorder.none,
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  InputDecoration textFieldOutlineStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Clr().newColor2.withOpacity(0.4),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Clr().shimmerColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
  );

  InputDecoration passwordFieldUnderlineStyle = InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().black,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().white,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  InputDecoration TextFormFieldOutlineDarkStyle = InputDecoration(
    filled: true,
    fillColor: Clr().white,
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d14,
      vertical: Dim().d12,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().black,
        width: 0.1,
      ),
      // borderRadius: BorderRadius.circular(
      //   Dim().d12,
      // ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().black,
        width: 0.1,
      ),
      // borderRadius: BorderRadius.circular(
      //   Dim().d12,
      // ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
        width: 0.1,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
        width: 0.1,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  InputDecoration TextFormFieldGreyDarkStyle = InputDecoration(
    filled: true,
    fillColor: Clr().lightGrey,
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d14,
      vertical: Dim().d12,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().lightGrey,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().lightGrey,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  InputDecoration TextFormFieldOutlineStyle = InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      horizontal: Dim().d14,
      vertical: Dim().d12,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().primaryColor,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().primaryColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Clr().errorRed,
      ),
    ),
    errorStyle: TextStyle(
      fontFamily: 'OpenSans',
      letterSpacing: 0.5,
      color: Clr().errorRed,
      fontSize: 14.0,
    ),
  );

  BoxDecoration dropDownUnderlineStyle = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Clr().black,
        width: 1,
      ),
    ),
  );

  BoxDecoration outlineBoxStyle = BoxDecoration(
    border: Border.all(
      color: Clr().lightGrey,
    ),
    borderRadius: BorderRadius.circular(Dim().d4),
  );

  BoxDecoration fillBoxStyle = BoxDecoration(
    color: Clr().white,
    borderRadius: BorderRadius.circular(Dim().d4),
  );

  BoxDecoration registerDropDownStyle = BoxDecoration(
    color: Clr().white,
    border: Border.all(
      color: Clr().lightGrey,
    ),
  );

  BoxDecoration profileDropDownStyle = BoxDecoration(
    color: Clr().lightGrey,
    border: Border.all(
      color: Clr().lightGrey,
    ),
    borderRadius: BorderRadius.circular(
      Dim().d12,
    ),
  );

  ButtonStyle primaryButton = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      vertical: Dim().d12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
  );

  ButtonStyle primaryButton2 = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      vertical: Dim().d12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
  );

  ButtonStyle whiteButton = ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      vertical: Dim().d4,
      horizontal: Dim().d20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        Dim().d12,
      ),
    ),
  );
}

class poppinsSty {
  TextStyle smalltext = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 14.0,
  );

  TextStyle microText = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 12.0,
  );
  TextStyle mediumText = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 16.0,
  );
  TextStyle mediumBoldText = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle largeText = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().black,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );
  TextStyle extraLargeText = TextStyle(
    fontFamily: name1,
    letterSpacing: 0.5,
    color: Clr().primaryColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w100,
  );
}
