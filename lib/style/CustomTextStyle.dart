import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static final TextStyle pressStart2pShadow = GoogleFonts.pressStart2p(
    fontWeight: FontWeight.w900,
    fontSize: 40.sp,
    color: const Color(0xfff5ddaf),
    shadows: [
      const Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black26,
      ),
    ],
  );

  static final TextStyle pressStart2p = GoogleFonts.pressStart2p(
    fontWeight: FontWeight.w900,
    fontSize: 25.sp,
    color: Colors.black87,
  );
}