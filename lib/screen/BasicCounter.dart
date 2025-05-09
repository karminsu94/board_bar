import 'package:board_bar/model/Player.dart';
import 'package:board_bar/widget/BasicCounterCard.dart';
import 'package:board_bar/widget/TimerWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicCounter extends StatefulWidget {
  @override
  _BasicCounterState createState() => _BasicCounterState();
}

class _BasicCounterState extends State<BasicCounter> {
  List<Player> _playerList = [];
  int _counter = 0;

  @override
  void initState() {
    // TODO: implement initState
    _playerList.add(Player(name: "Player1", score: 0));
    _playerList.add(Player(name: "Player2", score: 0));
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
      backgroundColor: const Color(0xfff9e0b2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff233c4c), width: 8.w),
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
                        String? playerName = await showModalBottomSheet<String>(
                          context: context,
                          builder: (BuildContext context) {
                            String inputName = '';
                            return Column(
                              children: [
                                Text('输入玩家名称'),
                                TextField(
                                  onChanged: (value) {
                                    inputName = value;
                                  },
                                  decoration:
                                      InputDecoration(hintText: '请输入名称'),
                                ),
                                TextButton(
                                  child: Text('确定'),
                                  onPressed: () {
                                    Navigator.of(context).pop(inputName);
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        if (playerName != null && playerName.isNotEmpty) {
                          setState(() {
                            _playerList.add(Player(name: playerName, score: 0));
                          });
                        }
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 50.sp,
                        color: Color(0xff233c4c),
                      ))),
            ]),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _playerList
                      .map((player) => BasicCounterCard(
                            playerName: player.name,
                            score: player.score,
                            scoreDetail: [],
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
