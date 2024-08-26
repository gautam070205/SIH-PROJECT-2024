import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

String googleApiKey = '';

const kPrimary = Color(0xFF30b9b2);
const kPrimaryLight = Color(0xFF40F3EA);
const kSecondary = Color(0xffffa44f);
const kSecondaryLight = Color(0xFFffe5db);
const kTertiary = Color(0xff0078a6);
const kGray = Color(0xff83829A);
const kGrayLight = Color(0xffC1C0C8);
const kLightWhite = Color(0xffFAFAFC);
const kWhite = Color(0xfffFFFFF);
const kDark = Color(0xff000000);
const kRed = Color(0xffe81e4d);
const kOffWhite = Color(0xffF3F4F8);

double height = 825.h;
double width = 375.w;

const String appBaseUrl = "http://172.16.79.90:6013";
// //1.Open Command prompt
// 2.Type ipconfig
// 3 .Copy ip Address and paste it here
// can also be worked on localhost
final List<String> verificationReasons = [
  'Real-time Updates: Get instant notifications about Your order Status',
  'Direct Communicaton: A verified number ensures seamless communication',
  'Enchanced  Security: Protect Your Account and confirm Orders securely',
  'Effortless Reschduling :Easily address issues with a quick call',
  'Exclusives Offers:Stay in the loop for special deals and promotions'
];