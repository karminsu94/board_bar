import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/Player.dart';
import '../style/CustomTextStyle.dart';
import 'FloatingText.dart';
import 'SimpleCalculator.dart';

class BasicCounterCard extends StatefulWidget {
  late Player player;
  Function callback;

  BasicCounterCard({
    super.key,
    required this.player,
    required this.callback,
  });

  @override
  State<BasicCounterCard> createState() => _BasicCounterCardState();
}

class _BasicCounterCardState extends State<BasicCounterCard> {
  bool _hasSwipedDown = false;
  bool _hasSwipedUp = false;
  bool _hasSwipedLeft = false;
  OverlayEntry? _overlayEntry;

  Color _randomColor = Color((0xFF000000 +
          (0x00FFFFFF *
                  (new DateTime.now().millisecondsSinceEpoch % 1000) /
                  1000)
              .toInt())
      .toInt());

  void _showFloatingText(BuildContext context, String text, Color color,
      double fontSize, double positionParma, bool isMovingUp) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: isMovingUp
            ? position.dy
            : position.dy + renderBox.size.height * 4 / 5,
        left: position.dx + renderBox.size.width / positionParma,
        child: FloatingText(
          text: text,
          color: color,
          fontSize: fontSize,
          isMovingUp: isMovingUp,
          onComplete: () {
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    int historyLength = 7;
    return Container(
        height: 190.h,
        decoration: BoxDecoration(
          // color: const Color(0xffb44f33),
          color: _randomColor,
          // borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15.h,
              right: 70.w,
              bottom: 0,
              child: Container(
                  width: 45.w,
                  height: 23.h,
                  decoration: BoxDecoration(
                      // border: Border.all(width: 3.w, color: Colors.black)
                      // color: const Color(0xff233c4c),
                      // borderRadius: BorderRadius.circular(10),
                      ),
                  child: ListView.builder(
                    itemCount: widget.player.scoreDetail.length > historyLength
                        ? historyLength
                        : widget.player.scoreDetail.length, // 固定最多显示7个
                    itemBuilder: (context, index) {
                      // 如果列表长度大于7，显示最后的7个
                      final displayIndex = widget.player.scoreDetail.length > historyLength
                          ? widget.player.scoreDetail.length - historyLength + index
                          : index;
                      return Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Text(widget.player.scoreDetail[displayIndex],
                            style: CustomTextStyle.pressStart2pShadow.copyWith(fontSize: 10.sp,color: Colors.amberAccent)),
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
                            widget.player.score = widget.player.score - 10;
                            widget.player.scoreDetail.add("-10");
                          });
                          _showFloatingText(
                              context, "-10", Colors.black87, 35.sp, 2.5, false);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 15.w, bottom: 5.w, left: 10.w),
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
                            widget.player.score = widget.player.score - 5;
                            widget.player.scoreDetail.add("-5");
                          });
                          _showFloatingText(
                              context, "-5", Colors.black87, 28.sp, 2.3, false);
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
                      widget.player.score = widget.player.score + 1;
                      widget.player.scoreDetail.add("+1");
                    });
                    _showFloatingText(
                        context, "+1", Colors.amberAccent, 20.sp, 2.3, true);
                  },
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy > 0.4 && !_hasSwipedDown) {
                      // 检测下滑操作
                      setState(() {
                        widget.player.score = widget.player.score - 1;
                        widget.player.scoreDetail.add("-1");
                        _hasSwipedDown = true;
                      });
                      _showFloatingText(
                          context, "-1", Colors.black87, 25.sp, 2.3, false);
                    }
                    // if (details.delta.dy < -0.4 && !_hasSwipedUp) {
                    //   // 检测上滑操作
                    //   setState(() {
                    //     // 如果scoreDetail不为空，才允许上滑
                    //     if (widget.scoreDetail.isNotEmpty) {
                    //       int latestValue = int.parse(widget
                    //           .scoreDetail[widget.scoreDetail.length - 1]);
                    //       widget.score = widget.score - latestValue;
                    //       widget.scoreDetail.removeLast();
                    //       _hasSwipedUp = true;
                    //     }
                    //   });
                    // }
                  },
                  onVerticalDragEnd: (details) {
                    _hasSwipedDown = false; // 重置标志，允许下一次下滑操作
                    _hasSwipedUp = false; // 重置标志，允许下一次上滑操作
                  },
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx < -0.2 && !_hasSwipedLeft) {
                      // 检测左滑操作
                      if (widget.player.scoreDetail.isNotEmpty) {
                        setState(() {
                          // 如果scoreDetail不为空，才允许上滑

                          int latestValue = int.parse(widget.player.scoreDetail[
                              widget.player.scoreDetail.length - 1]);
                          widget.player.score =
                              widget.player.score - latestValue;
                          widget.player.scoreDetail.removeLast();
                          _hasSwipedLeft = true;
                        });
                        _showFloatingText(
                            context, "↩", Colors.white70, 25.sp, 2.3, false);
                      }
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    _hasSwipedLeft = false; // 重置标志，允许下一次左滑操作
                  },
                  onLongPress: () async {
                    int calculatedScore = widget.player.score;
                    List<String> calculatedDetail = widget.player.scoreDetail;

                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8, // 设置高度为屏幕的80%
                          child: SimpleCalculator(
                            score: calculatedScore,
                            scoreDetail: calculatedDetail,
                            callback:
                                (int cScore, List<String> cScoreDetail) {
                              calculatedScore = cScore;
                              calculatedDetail = cScoreDetail;
                            },
                          ),
                        );
                      },
                    );

                    setState(() {
                      widget.player.score = calculatedScore;
                      widget.player.scoreDetail = calculatedDetail;
                    });
                  },
                  child: Container(
                    width: 280.w,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onLongPress: () async {
                            Map<dynamic, dynamic>? result =
                                await showModalBottomSheet<Map>(
                              context: context,
                              backgroundColor: const Color(0xfff9e0b2), // 设置背景色
                              builder: (BuildContext context) {
                                String inputName = '';
                                Color selectedColor = _randomColor;
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 480.h,
                                      child: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('添加玩家名称',
                                              style:
                                                  CustomTextStyle.pressStart2p),
                                          SizedBox(height: 35.h),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xff233c4c),
                                                    width: 8.w),
                                                color: Colors.white70),
                                            width: 350.w,
                                            child: TextField(
                                              controller: TextEditingController(
                                                  text: widget.player.name),
                                              textAlign: TextAlign.center,
                                              onChanged: (value) {
                                                inputName = value;
                                              },
                                              decoration: InputDecoration(
                                                  hintText: '请输入名称',
                                                  hintStyle: CustomTextStyle
                                                      .pressStart2p
                                                      .copyWith(
                                                    fontSize: 20.sp,
                                                  )),
                                              style: CustomTextStyle
                                                  .pressStart2p
                                                  .copyWith(
                                                      fontSize: 20.sp,
                                                      fontWeight: null),
                                            ),
                                          ),
                                          SizedBox(height: 15.h),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedColor = Color((0xFF000000 +
                                                        (0x00FFFFFF *
                                                                (DateTime.now()
                                                                        .millisecondsSinceEpoch %
                                                                    1000) /
                                                                1000)
                                                            .toInt())
                                                    .toInt());
                                              });
                                            },
                                            child: Container(
                                                width: 40.w,
                                                height: 40.w,
                                                decoration: BoxDecoration(
                                                  color: selectedColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.r),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xff1e3b43),
                                                      width: 5.w),
                                                )),
                                          ),
                                          SizedBox(height: 35.h),
                                          TextButton(
                                            child: Text(
                                              '确定',
                                              style:
                                                  CustomTextStyle.pressStart2p,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop({
                                                'name': inputName,
                                                'color': selectedColor
                                              });
                                            },
                                          ),
                                          SizedBox(height: 15.h),
                                          TextButton(
                                            child: Text(
                                              '删除',
                                              style:
                                                  CustomTextStyle.pressStart2p,
                                            ),
                                            onPressed: () {
                                              widget.callback(widget.player);
                                              Navigator.of(context)
                                                  .pop(); // 关闭弹窗
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                            setState(() {
                              if (result != null &&
                                  result['name'] != null &&
                                  result['name'].isNotEmpty) {
                                widget.player.name = result['name'];
                              } else if (result!['color'] != _randomColor) {
                                _randomColor = result['color'];
                              }
                            });
                          },
                          child: Text(
                            widget.player.name,
                            style: CustomTextStyle.pressStart2pShadow.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "${widget.player.score}",
                          style: CustomTextStyle.pressStart2pShadow,
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
                            widget.player.score = widget.player.score + 10;
                            widget.player.scoreDetail.add("+10");
                          });
                          _showFloatingText(context, "+10", Colors.yellowAccent,
                              35.sp, 2.5, true);
                        },
                        child: Container(
                          // padding: EdgeInsets.all(3.w),
                          margin: EdgeInsets.only(
                              top: 15.w, bottom: 5.w, right: 10.w),
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
                            widget.player.score = widget.player.score + 5;
                            widget.player.scoreDetail.add("+5");
                          });
                          _showFloatingText(
                              context, "+5", Colors.yellow, 28.sp, 2.3, true);
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
