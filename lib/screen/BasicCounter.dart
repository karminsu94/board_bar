import 'package:board_bar/model/Player.dart';
import 'package:board_bar/style/CustomTextStyle.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BasicCounter extends StatefulWidget {
  @override
  _BasicCounterState createState() => _BasicCounterState();
}

class _BasicCounterState extends State<BasicCounter> {
  List<Player> _playerList = [];

  @override
  void initState() {
    // TODO: implement initState
    _playerList.add(Player(name: "Player1", score: 0));
    _playerList.add(Player(name: "Player2", score: 0));
    _playerList.add(Player(name: "Player3", score: 0));
    _playerList.add(Player(name: "Player4", score: 0));
    super.initState();
  }

  void _incrementCounter(Player player) {
    setState(() {
      player.score++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffaaaaaa),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff233c4c), width: 8.w),
                                  color: Color(0xff326171)),
                              margin: EdgeInsets.only(bottom: 25.h, top: 25.h),
                              width: 250.w,
                              child: TimerWidget()),
                        ],
                      ),
                      Positioned(
                          right: 0,
                          child: IconButton(
                              onPressed: () async {
                                String? playerName =
                                    await showModalBottomSheet<String>(
                                  context: context,
                                  backgroundColor: const Color(0xfff9e0b2),
                                  // 设置背景色
                                  builder: (BuildContext context) {
                                    String inputName = '';
                                    return SizedBox(
                                      width: double.infinity,
                                      height: 350.h,
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
                                          SizedBox(height: 35.h),
                                          TextButton(
                                            child: Text(
                                              '确定',
                                              style:
                                                  CustomTextStyle.pressStart2p,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(inputName);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                if (playerName != null &&
                                    playerName.isNotEmpty) {
                                  setState(() {
                                    _playerList.add(
                                        Player(name: playerName, score: 0));
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.add_circle_outline,
                                size: 50.sp,
                                color: Color(0xff233c4c),
                              ))),
                    ]),
                    Column(
                      children: _playerList
                          .map((player) => BasicCounterCard(
                              player: player,
                              callback: (player) {
                                setState(() {
                                  _playerList.remove(player);
                                });
                              }))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
