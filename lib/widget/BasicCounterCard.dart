import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicCounterCard extends StatefulWidget {
  final String playerName;
  late int score;

  BasicCounterCard({
    super.key,
    required this.playerName,
    required this.score,
  });

  @override
  State<BasicCounterCard> createState() => _BasicCounterCardState();
}

class _BasicCounterCardState extends State<BasicCounterCard> {
  bool _hasSwiped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: const Color(0xffb44f33),
          // borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border(
            top: BorderSide(color: Color(0xff233c4c), width: 8.h),
            // bottom:  BorderSide(color: Color(0xff233c4c), width: 6.h),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.score = widget.score - 10;
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.all(3.w),
                      margin:
                          EdgeInsets.only(top: 5.w, bottom: 5.w, left: 10.w),
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff335f70),
                        border: Border.all(
                            color: const Color(0xff1e3b43), width: 5.w),
                      ),
                      child: Center(
                        child: Text("-10",
                            style: GoogleFonts.pressStart2p(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                                color: const Color(0xfff5ddaf))),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.score = widget.score - 5;
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.all(3.w),
                      margin:
                          EdgeInsets.only(top: 5.w, bottom: 5.w, left: 10.w),
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff335f70),
                        border: Border.all(
                            color: const Color(0xff1e3b43), width: 5.w),
                      ),
                      child: Center(
                        child: Text("-5",
                            style: GoogleFonts.pressStart2p(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                                color: const Color(0xfff5ddaf))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
           GestureDetector(
             onTap: () {
               setState(() {
                 widget.score = widget.score + 1;
               });
             },
             onVerticalDragUpdate: (details) {
               if (details.delta.dy > 0.4 && !_hasSwiped) {
                 // 检测下滑操作
                 setState(() {
                   widget.score = widget.score - 1;
                   _hasSwiped = true;
                 });
               }
             },
             onVerticalDragEnd: (details) {
               _hasSwiped = false; // 重置标志，允许下一次下滑操作
             },
             child: Container(
               width: 280.w,
               color: Colors.transparent,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     widget.playerName,
                     style: GoogleFonts.pressStart2p(
                         fontWeight: FontWeight.w900,
                         fontSize: 25.sp,
                         color: const Color(0xfff5ddaf)),
                   ),
                   SizedBox(
                     height: 15.h,
                   ),
                   Text(
                     "${widget.score}",
                     style: GoogleFonts.pressStart2p(
                         fontWeight: FontWeight.w900,
                         fontSize: 40.sp,
                         color: const Color(0xfff5ddaf)),
                   ),
                 ],
               ),
             ),
           ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.score = widget.score + 10;
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.all(3.w),
                      margin:
                          EdgeInsets.only(top: 5.w, bottom: 5.w, right: 10.w),
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff335f70),
                        border: Border.all(
                            color: const Color(0xff1e3b43), width: 5.w),
                      ),
                      child: Center(
                        child: Text("+10",
                            style: GoogleFonts.pressStart2p(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                                color: const Color(0xfff5ddaf))),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.score = widget.score + 5;
                      });
                    },
                    child: Container(
                      // padding: EdgeInsets.all(3.w),
                      margin:
                          EdgeInsets.only(top: 5.w, bottom: 5.w, right: 10.w),
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: const Color(0xff335f70),
                        border: Border.all(
                            color: const Color(0xff1e3b43), width: 5.w),
                      ),
                      child: Center(
                        child: Text("+5",
                            style: GoogleFonts.pressStart2p(
                                fontWeight: FontWeight.w300,
                                fontSize: 12.sp,
                                color: const Color(0xfff5ddaf))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
