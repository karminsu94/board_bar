import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SimpleCalculator.dart';

class BasicCounterCard extends StatefulWidget {
  final String playerName;
  late int score;
  late List<String> scoreDetail;

  BasicCounterCard({
    super.key,
    required this.playerName,
    required this.score,
    required this.scoreDetail,
  });

  @override
  State<BasicCounterCard> createState() => _BasicCounterCardState();
}

class _BasicCounterCardState extends State<BasicCounterCard> {
  bool _hasSwipedDown = false;
  bool _hasSwipedUp = false;

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
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 63.w,
              bottom: 0,
              child: Container(
                  width: 35.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 3.w, color: Colors.black)
                      // color: const Color(0xff233c4c),
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: ListView.builder(
                    itemCount: widget.scoreDetail.length > 9
                        ? 9
                        : widget.scoreDetail.length, // 固定最多显示9个
                    itemBuilder: (context, index) {
                      // 如果列表长度大于9，显示最后的9个
                      final displayIndex = widget.scoreDetail.length > 9
                          ? widget.scoreDetail.length - 9 + index
                          : index;
                      return Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Text(widget.scoreDetail[displayIndex],
                            style: GoogleFonts.pressStart2p(
                                fontSize: 8.sp, color: Colors.amber)),
                      );
                    },
                  )),
            ),
            Row(
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
                            widget.scoreDetail.add("-10");
                          });
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, left: 10.w),
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
                            widget.scoreDetail.add("-5");
                          });
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, left: 10.w),
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
                      widget.scoreDetail.add("+1");
                    });
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0.4 && !_hasSwipedDown) {
                      // 检测下滑操作
                      setState(() {
                        widget.score = widget.score - 1;
                        widget.scoreDetail.add("-1");
                        _hasSwipedDown = true;
                      });
                    }
                    if (details.delta.dy < -0.4 && !_hasSwipedUp) {
                      // 检测上滑操作
                      setState(() {
                        // 如果scoreDetail不为空，才允许上滑
                        if (widget.scoreDetail.isNotEmpty) {
                          int latestValue = int.parse(widget
                              .scoreDetail[widget.scoreDetail.length - 1]);
                          widget.score = widget.score - latestValue;
                          widget.scoreDetail.removeLast();
                          _hasSwipedUp = true;
                        }
                      });
                    }
                  },
                  onVerticalDragEnd: (details) {
                    _hasSwipedDown = false; // 重置标志，允许下一次下滑操作
                    _hasSwipedUp = false; // 重置标志，允许下一次上滑操作
                  },
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8, // 设置高度为屏幕的80%
                          child: SimpleCalculator(
                            score: widget.score,
                            scoreDetail: widget.scoreDetail,
                            callback: (int cScore, List<String> cScoreDetail) {
                              setState(() {
                                widget.score=cScore;
                                widget.scoreDetail=cScoreDetail;
                              });
                          },
                          ),
                        );
                      },
                    );
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
                            widget.scoreDetail.add("+10");
                          });
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, right: 10.w),
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
                            widget.scoreDetail.add("+5");
                          });
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 5.w, bottom: 5.w, right: 10.w),
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
            ),
          ],
        ));
  }
}
