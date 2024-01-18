import 'package:flutter/material.dart';

///[SizedBox const]
const kSBH1 = SizedBox(height: 1);
const kSBH100 = SizedBox(
  height: 100,
);
const kSBH120 = SizedBox(
  height: 120,
);

const kSBH10 = SizedBox(height: 10);
const kSBH500 = SizedBox(height: 500);
const kSBH30 = SizedBox(height: 30);
const kSBH11 = SizedBox(height: 11);
const kSBW10 = SizedBox(width: 10);
const kSBW12 = SizedBox(width: 12);
const kSBW48 = SizedBox(width: 48);
const kSBW44 = SizedBox(width: 44);
const kSBW40 = SizedBox(width: 40);
const kSBW16 = SizedBox(width: 16);
const kSBH12 = SizedBox(height: 12);
const kSBH18 = SizedBox(height: 18);
const kSBH26 = SizedBox(height: 26);
const kSBH23 = SizedBox(height: 23);
const kSBH60 = SizedBox(height: 60);
const kSBW4 = SizedBox(width: 4);
const kSBW14 = SizedBox(width: 14);
const kSBW2 = SizedBox(width: 2);
const kSBW28 = SizedBox(width: 28);

const kSBW6 = SizedBox(width: 6);
const kSBW8 = SizedBox(width: 8);
const kSBH8 = SizedBox(height: 8);
const kSBH2 = SizedBox(height: 2);
const kSBH4 = SizedBox(height: 4);
const kSBH32 = SizedBox(height: 32);
const kSBW32 = SizedBox(width: 32);
const kSBW24 = SizedBox(width: 24);
const kSBH36 = SizedBox(height: 36);
const kSBH38 = SizedBox(height: 38);
const kSBH40 = SizedBox(height: 40);
const kSBH20 = SizedBox(height: 20);
const kSBH25 = SizedBox(height: 25);
const kSBH24 = SizedBox(height: 24);
const kSBH50 = SizedBox(height: 50);
const kSBH48 = SizedBox(height: 48);
const kSBH54 = SizedBox(height: 54);
const kSBH15 = SizedBox(height: 15);
const kSBW20 = SizedBox(width: 20);
const kSBH16 = SizedBox(height: 16);
const kNothing = SizedBox.shrink();

///Padding
const kPLR24 = EdgeInsets.only(left: 24, right: 24);
const kPL10TBR12 = EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 12);
const kPRTB14 = EdgeInsets.only(right: 14, top: 14, bottom: 14);
const kPL5R5 = EdgeInsets.only(left: 5, right: 5);
const kPL10R10T5 = EdgeInsets.only(left: 10, right: 10, top: 5);
const kPL10R10T3 = EdgeInsets.only(left: 10, right: 10, top: 3);
const kPL10R10B2 = EdgeInsets.only(left: 10, right: 10, bottom: 2);
const kPL10R10 = EdgeInsets.only(left: 10, right: 10);
const kPL10R5 = EdgeInsets.only(left: 10, right: 5);

const kPL10R10B5 = EdgeInsets.only(left: 10, right: 10, bottom: 10);
const kPR5 = EdgeInsets.only(right: 5);
const kPB24 = EdgeInsets.only(bottom: 24);
const kP8 = EdgeInsets.all(8.0);
const kPLR10 = EdgeInsets.only(left: 10, right: 10);
const kPB5 = EdgeInsets.only(bottom: 5);
const kPB10 = EdgeInsets.only(bottom: 10);
const kPSV5 = EdgeInsets.symmetric(vertical: 5);
const kPL40R125 = EdgeInsets.only(left: 40, right: 125);
const kPBR5 = EdgeInsets.only(bottom: 5, right: 5);
const kPL8R5T5B5 = EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5);
const kPL5R8T5B5 = EdgeInsets.only(left: 5, right: 8, top: 5, bottom: 5);
const kPT5 = EdgeInsets.only(top: 5);
const kPT8 = EdgeInsets.only(top: 8);
const kPT10 = EdgeInsets.only(top: 10);
const kPL5 = EdgeInsets.only(left: 5.0);
const kPL22 = EdgeInsets.only(left: 22);
const kPR23 = EdgeInsets.only(right: 23);
const kPR10 = EdgeInsets.only(right: 10);
const kPL10 = EdgeInsets.only(left: 10);
const kPH12V8 = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
const kPH15 = EdgeInsets.symmetric(horizontal: 15);
const kPH8 = EdgeInsets.symmetric(horizontal: 8);
const kPH16 = EdgeInsets.symmetric(horizontal: 16);

const kPH32 = EdgeInsets.symmetric(horizontal: 32);

const kP10 = EdgeInsets.all(10);
const kP5 = EdgeInsets.all(5);
const kP3 = EdgeInsets.all(3);
const kP16 = EdgeInsets.all(16);
const kPL16 = EdgeInsets.only(left: 16);
const kPT16B16 = EdgeInsets.only(top: 16, bottom: 16);
const kPL5B2 = EdgeInsets.only(left: 5, bottom: 2);
const kPB8 = EdgeInsets.only(bottom: 8);
const kPTB5 = EdgeInsets.only(top: 5, bottom: 5);
const defaultDialogInsetPadding =
    EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

//Decortion

//BorderRadius
const Radius bubbleRadius = Radius.circular(15);
const BorderRadius bubbleBorderRadius = BorderRadius.all(bubbleRadius);

//profile
//container
const Radius containerProfile = Radius.circular(12);
const BorderRadius containerProfileBorderRadius =
    BorderRadius.all(containerProfile);
//photos
const Radius photos = Radius.circular(10);
const BorderRadius photosBorderRadius = BorderRadius.all(photos);
//moments
const Radius momentsRadius = Radius.circular(12);
const BorderRadius momentsBorderRadius = BorderRadius.all(momentsRadius);
//chronicles
const Radius chronicles = Radius.circular(18);
const BorderRadius chroniclesBorderRadius = BorderRadius.all(chronicles);
const List<BoxShadow> containerProfileBoxShadow = [
  BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1),
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.15),
    offset: Offset(0, 1),
    blurRadius: 2,
  )
];
//moments shadows
const List<Shadow> momentsShadowList = [
  Shadow(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      offset: Offset(0, 1.5),
      blurRadius: 3)
];

//chronicle shadows
const List<BoxShadow> chronicleShadowList = [
  BoxShadow(
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.30),
      offset: Offset(0, 1),
      blurRadius: 2),
  BoxShadow(
      spreadRadius: 1,
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 1),
      blurRadius: 3)
];
//quiz chronicle answer shadows

const List<BoxShadow> quizAnswerShadowList = [
  BoxShadow(
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.30),
      offset: Offset(0, 2),
      blurRadius: 3),
  BoxShadow(
      spreadRadius: 4,
      color: Color.fromRGBO(0, 0, 0, 0.15),
      offset: Offset(0, 6),
      blurRadius: 10)
];
